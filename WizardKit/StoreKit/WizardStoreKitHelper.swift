//
//  WizardStoreKitHelper.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-04-02.
//

import Foundation
import StoreKit
import SwiftUI
import os.log

/// Protocol that each app implements to define its product catalog
/// and handle purchase side-effects (setting UserDefaults flags, etc.)
public protocol WizardStoreKitDelegate: AnyObject {
    /// All product identifiers this app needs loaded from the App Store.
    func allProductIdentifiers() -> [String]

    /// Called when a verified transaction is received (purchase or entitlement restore).
    @MainActor func handleVerifiedTransaction(_ transaction: StoreKit.Transaction) async

    /// Called after all currentEntitlements have been iterated.
    @MainActor func didFinishValidatingEntitlements() async
}

public extension WizardStoreKitDelegate {
    func didFinishValidatingEntitlements() async {}
}

@Observable
@MainActor
public final class WizardStoreKitHelper {

    public var products: [Product] = []
    public var purchaseSuccess: Bool = false

    private var transactionListener: Task<Void, Error>?
    private let logger: Logger
    private weak var delegate: WizardStoreKitDelegate?

    public init(delegate: WizardStoreKitDelegate, subsystem: String = Bundle.main.bundleIdentifier ?? "WizardKit") {
        self.delegate = delegate
        self.logger = Logger(subsystem: subsystem, category: "storekit")
        self.transactionListener = listenForTransactions()
        Task { await loadProducts() }
    }

    // MARK: - Products

    public func loadProducts() async {
        guard let delegate else { return }
        do {
            let identifiers = delegate.allProductIdentifiers()
            let storeProducts = try await Product.products(for: identifiers)
            self.products = storeProducts
        } catch {
            logger.error("Failed to load products: \(error.localizedDescription)")
        }
    }

    public func product(for identifier: String) -> Product? {
        products.first { $0.id == identifier }
    }

    // MARK: - Purchase

    public func purchase(_ product: Product) async throws {
        guard AppStore.canMakePayments else { return }

        let result: Product.PurchaseResult
        if let scene = UIApplication.shared.currentScene {
            result = try await product.purchase(confirmIn: scene)
        } else {
            result = try await product.purchase()
        }

        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await delegate?.handleVerifiedTransaction(transaction)
            await transaction.finish()
            togglePurchaseSuccess()
        case .userCancelled:
            logger.info("User cancelled purchase")
        case .pending:
            logger.info("Purchase pending approval")
        @unknown default:
            break
        }
    }

    // MARK: - Restore

    public func restorePurchases() async {
        do {
            try await AppStore.sync()
            await validateEntitlements()
        } catch {
            logger.error("Restore failed: \(error.localizedDescription)")
        }
    }

    // MARK: - Entitlements

    public func validateEntitlements() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                await delegate?.handleVerifiedTransaction(transaction)
            } catch {
                logger.error("Entitlement verification failed: \(error.localizedDescription)")
            }
        }
        await delegate?.didFinishValidatingEntitlements()
    }

    // MARK: - Transaction Listener

    private func listenForTransactions() -> Task<Void, Error> {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                do {
                    let transaction = try self.checkVerified(result)
                    await self.delegate?.handleVerifiedTransaction(transaction)
                    await transaction.finish()
                } catch {
                    // Verification failed; skip
                }
            }
        }
    }

    // MARK: - Helpers

    private nonisolated func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error): throw error
        case .verified(let value): return value
        }
    }

    private func togglePurchaseSuccess() {
        withAnimation { self.purchaseSuccess = true }
        Task {
            try? await Task.sleep(for: .seconds(30))
            self.purchaseSuccess = false
        }
    }

    // MARK: - Subscription Period Formatting

    public func subscriptionPeriodLabel(for product: Product) -> String {
        guard let subscription = product.subscription else { return "" }
        let period = subscription.subscriptionPeriod
        let value = period.value
        let unit = period.unit
        let plural = value > 1
        switch (unit, plural) {
        case (.day, false):   return "Day"
        case (.day, true):    return "\(value) Days"
        case (.week, false):  return "Week"
        case (.week, true):   return "\(value) Weeks"
        case (.month, false): return "Month"
        case (.month, true):  return "\(value) Months"
        case (.year, false):  return "Year"
        case (.year, true):   return "\(value) Years"
        @unknown default:     return "Unknown"
        }
    }
}
