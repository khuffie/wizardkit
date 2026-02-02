//
//  ViewModifiers+Extensions.swift
//  WidgetWizardKit
//
//  Created by Ahmed El-Khuffash on 2020-09-11.
//

import Foundation
import SwiftUI
import WizardKit



extension Text {
	
	public func textHeader() -> some View {
		self.foregroundColor(.themeAccent)
			.font(.system(size: 12))
            .fontWeight(.light)
			.padding(.trailing, 5)
	}

	public func headerFontWeight() -> some View {
        self.fontWeight(.medium)
	}

	
	public func primaryFontWeight() -> some View {
        self.fontWeight(.regular)
	}
	
	public func secondaryFontWeight() -> some View {
        self.fontWeight(.light)
	}

	
}
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
			.accentColor(.themeAccent)
			.foregroundColor(.themeAccent)
	}
}

public struct SectionHeader: ViewModifier {
	public func body(content: Content) -> some View {
		VStack(alignment: .leading) {
			content
				.font(.headline)
				.foregroundColor(.themeAccent)
			Divider()
				.frame(height: 1)
				.background(Color.themeAccent)
				.padding(.top, -10)
		}
	}
}

public struct PrimaryButton: ViewModifier {
	public func body(content: Content) -> some View {
		content
			.padding(8)
			.padding([.trailing, .leading], 10)
			.background(Color.themeAccent)
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
			.background(Color.themeBackground)
			//.background(colorScheme == .dark ? Color.cardBackgroundColor.opacity(opacity) : Color.themeAccent.opacity(0.1))
			.cornerRadius(15)
	}

}


public struct WizardProgressViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .tint(.themeAccent)
    }
}





public struct WeatherIconShadow:ViewModifier {
	
	@Environment(\.colorScheme) var colorScheme

	
	public func body(content: Content) -> some View {
		
		content
			.if(checkIsWhite()) {
				$0
					.shadow(color: Color.black.opacity(0.2), radius: 1, x: 1, y: 1)
					.shadow(color: Color.black.opacity(0.2), radius: 1, x: -1, y: -1)
					.shadow(color: Color.black.opacity(0.2), radius: 1, x: 1, y: -1)

				
			}

		
	}

	
	func checkIsWhite() -> Bool {
		
		if colorScheme == .dark {
			return Theme.shared.dark.backgroundColor.isWhite
		} else {
			return Theme.shared.light.backgroundColor.isWhite
		}
		
	}
	
}



public struct RowModifier:ViewModifier {
	
	let opacity: Double
	@Environment(\.colorScheme) var colorScheme
	
	public func body(content: Content) -> some View {
		content
			.padding(10)
			.foregroundColor(Color.themeAccent)
			.background(Color.themeBackground)

			//.background(colorScheme == .dark ? Color.cardBackgroundColor.opacity(opacity) : Color.themeAccent.opacity(0.1))
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
			//.background(colorScheme == .dark ? Color.cardBackgroundColor.opacity(opacity) : Color.themeAccent.opacity(0.1))
			.background(Color.themeBackground)
			.cornerRadius(15)
//			.padding([.leading, .trailing])
//			.padding(.bottom, 10)

			
	}

	
}

public struct WidgetModifier:ViewModifier {
	
	@Environment(\.colorScheme) var colorScheme

	
	public func body(content: Content) -> some View {
		content
			.padding(16)
			.foregroundColor(.themePrimary)
			.accentColor(.themeAccent)
			//.background(Color.themeBackground)
			
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

extension LazyVStack {
	public func card(opacity: Double = 1.0) -> some View {
		self.modifier(CardModifier(opacity: opacity))
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
			.colorInvert().colorMultiply(.themeAccent)
			.foregroundColor(Color.themeAccent)
	}


}

extension ProgressView {
    public func wizardProgressView() -> some View {
        self.modifier(WizardProgressViewModifier())
    }
}

extension View {
	public func iconShadow() -> some View {
		self.modifier(WeatherIconShadow())
	}

}


extension View {
  @ViewBuilder
  func `if`<Transform: View>(
	_ condition: Bool,
	transform: (Self) -> Transform
  ) -> some View {
	if condition {
	  transform(self)
	} else {
	  self
	}
  }
}
