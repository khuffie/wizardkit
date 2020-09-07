//
//  ViewModifier+Extensions.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-31.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import SwiftUI

public struct TextButton: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .accentColor(.main)
    }
}

public struct SectionHeader: ViewModifier {
    public func body(content: Content) -> some View {
		VStack(alignment: .leading) {
			content
				.font(.headline)
				.foregroundColor(.main)
			Divider()
				.frame(height: 1)
				.background(Color.main)
				.padding(.top, -10)
		}
	}
}

public struct PrimaryButton: ViewModifier {
	public func body(content: Content) -> some View {
		content
			.padding(8)
			.padding([.trailing, .leading], 10)
			.background(Color.main)
			.cornerRadius(8)
			.foregroundColor(.white)
	}
}

public struct CardModifier:ViewModifier {
	
    let opacity: Double
	@Environment(\.colorScheme) var colorScheme
	
	public func body(content: Content) -> some View {
		content
			.padding()
			.background(colorScheme == .dark ? Color.cardBackgroundColor.opacity(opacity) : Color.main.opacity(0.1))
			.cornerRadius(15)
	}

}

public struct RowModifier:ViewModifier {
	
	let opacity: Double
	@Environment(\.colorScheme) var colorScheme
	
	public func body(content: Content) -> some View {
		content
			.padding(10)
			.background(colorScheme == .dark ? Color.cardBackgroundColor.opacity(opacity) : Color.main.opacity(0.1))
			.cornerRadius(5)
	}

}

public struct WidgetInAppModifier:ViewModifier {
	
	let opacity: Double
	@Environment(\.colorScheme) var colorScheme

	
	public func body(content: Content) -> some View {
		content
			.frame(height: 150)
			//.background(Color.cardBackgroundColor.opacity(opacity))
			.background(colorScheme == .dark ? Color.cardBackgroundColor.opacity(opacity) : Color.main.opacity(0.1))
			.cornerRadius(15)
			.padding([.leading, .trailing])
			.padding(.bottom, 10)

			
	}

	
}

public struct WidgetModifier:ViewModifier {
	
	@Environment(\.colorScheme) var colorScheme

	
	public func body(content: Content) -> some View {
		content
			.padding(16)
			.background(Color.widgetBackgroundColor)
			
	}

	
}

import Combine
import SwiftUI


//from https://stackoverflow.com/questions/58733003/swiftui-how-to-create-textfield-that-only-accepts-numbers
public struct NumberOnlyViewModifier: ViewModifier {

	@Binding var text: String

	public init(text: Binding<String>) {
		self._text = text
	}

	public func body(content: Content) -> some View {
		content
			.keyboardType(.numberPad)
			.onReceive(Just(text)) { newValue in
				let filtered = newValue.filter { "0123456789".contains($0) }
				if filtered != newValue {
					self.text = filtered
				}
			}
	}
}

extension TextField {
	public func numeric(text: Binding<String>) -> some View {
		self.modifier(NumberOnlyViewModifier(text: text))
	}
}

extension VStack {
	public func card(opacity: Double = 1.0) -> some View {
		self.modifier(CardModifier(opacity: opacity))
	}
	
	public func widget() -> some View {
		self.modifier(WidgetModifier())

	}
	
	public func widgetInApp(opacity: Double = 1.0) -> some View {
		self.modifier(WidgetInAppModifier(opacity: opacity))
	}

}

extension HStack {
	public func card(opacity: Double = 1.0) -> some View {
		self.modifier(CardModifier(opacity: opacity))
	}
	
	public func row(opacity: Double = 1.0) -> some View {
		self.modifier(RowModifier(opacity: opacity))
	}

	
	public func widget() -> some View {
		self.modifier(WidgetModifier())

	}

	
	public func widgetInApp(opacity: Double = 1.0) -> some View {
		self.modifier(WidgetInAppModifier(opacity: opacity))
	}

}




extension Text {
	public func textButton() -> some View {
		self.modifier(TextButton())
	}
	
	public func textHeader() -> some View {
		self.foregroundColor(.main)
			.font(.system(size: 12)).bold()
			//.fontWeight(bold())
			.padding(.trailing, 5)
	}
	
	public func primaryButton() -> some View {
		self.modifier(PrimaryButton())
	}
	
	public func sectionHeader() -> some View {
		self.modifier(SectionHeader())
	}
}
extension Button {
	public func textButton() -> some View {
		self.modifier(TextButton())
	}
	public func primaryButton() -> some View {
		self.modifier(PrimaryButton())
	}
}

extension Image {
	public func socialButton() -> some View {
		self
			.resizable()
			.frame(width: 25, height: 25)
			.colorInvert().colorMultiply(.main)
			.foregroundColor(Color.main)
	}
}
