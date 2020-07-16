//
//  WizardHelper.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-06-17.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import UIKit

public class WizardHelper {
	

	public static func getHTMLLabel(with html:String) ->UITextView {
		let label = UITextView()
		label.isEditable = false

		let font = UIFont.systemFont(ofSize: 18)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.label
		]
		
		
		let data = Data(html.utf8)
		DispatchQueue.main.async {
		if let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
				
			
			attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
				
				label.attributedText = attributedString

			}
		}
		return label
	}
}
