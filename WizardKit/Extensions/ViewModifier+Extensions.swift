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

	
	public func body(content: Content) -> some View {
		content
			.padding()
			.background(Color.cardBackgroundColor.opacity(opacity))
			.cornerRadius(15)
	}

}

public struct WidgetModifier:ViewModifier {
	
	let opacity: Double

	
	public func body(content: Content) -> some View {
		content
			.frame(width: 340, height: 150)
			.background(Color.cardBackgroundColor.opacity(opacity))
			.cornerRadius(25)
			
	}

	
}

extension VStack {
	public func card(opacity: Double = 1.0) -> some View {
		self.modifier(CardModifier(opacity: opacity))
	}
	
	public func widget(opacity: Double = 1.0) -> some View {
		self.modifier(WidgetModifier(opacity: opacity))
	}

}

extension HStack {
	public func card(opacity: Double = 1.0) -> some View {
		self.modifier(CardModifier(opacity: opacity))
	}
	
	public func widget(opacity: Double = 1.0) -> some View {
		self.modifier(WidgetModifier(opacity: opacity))
	}

}




extension Text {
	public func textButton() -> some View {
		self.modifier(TextButton())
	}
	
	public func textHeader() -> some View {
		self.foregroundColor(.main)
			.font(.caption).bold()
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
