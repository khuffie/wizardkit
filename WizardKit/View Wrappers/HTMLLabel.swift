import WebKit
import SwiftUI

/**
A custom HTMLLabel that creates a UITextView, converts the HTML to an NSAttributedString and displays it, as the SwiftUI Text view cannot display HTML content.
*/
public struct HTMLLabel: UIViewRepresentable {
	
	public init(html: String) {
		self.html = html
	}
	
	
	public let html: String
	
	public func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
		
		
		return WizardHelper.getHTMLLabel(with: html)
	}
	
	public func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {}

}
