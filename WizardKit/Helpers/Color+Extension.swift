//
//  Color+Extension.swift
//  WidgetWizardKit
//
//  Created by Ahmed El-Khuffash on 2020-08-23.
//

import Foundation
import SwiftUI


extension Color {
	
	public var isWhite:Bool {
		//print("Color.isWhite \(UIColor(self).description )")
		
		let uicolor = UIColor(self)
//
//		var green:CGFloat = 0
//		var red:CGFloat = 0
//		var blue:CGFloat = 0
//		var alpha:CGFloat = 0
//
//		if uicolor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
//			print(red)
//			print(green)
//			print(blue)
//			print(alpha)
//		}
//
//
//		print( uicolor.toHex)
		
		if uicolor.toHex != nil && (uicolor.toHex == "FFFFFF" || uicolor.toHex == "FFFFFFFF") {
			return true
		} else {
			return false
		}
		
	}
	
	
}


// MARK:  DARKER
/*
https://stackoverflow.com/questions/38435308/get-lighter-and-darker-color-variations-for-a-given-uicolor
*/


extension Color {
	public func lighter(by amount: CGFloat = 30) -> Self { Self(UIColor(self).lighter(by: amount)) }
	public func darker(by amount: CGFloat = 30) -> Self { Self(UIColor(self).darker(by: amount)) }
}

extension UIColor {
  /**
   Create a ligher color
   */
  func lighter(by percentage: CGFloat = 30.0) -> UIColor {
	return self.adjustBrightness(by: abs(percentage))
  }

  /**
   Create a darker color
   */
  func darker(by percentage: CGFloat = 30.0) -> UIColor {
	return self.adjustBrightness(by: -abs(percentage))
  }

  /**
   Try to increase brightness or decrease saturation
   */
  func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
	var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
	if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
	  if b < 1.0 {
		let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
		return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
	  } else {
		let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
		return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
	  }
	}
	return self
  }
}

/*
extension UIColor {
	func mix(with color: UIColor, amount: CGFloat) -> Self {
		var red1: CGFloat = 0
		var green1: CGFloat = 0
		var blue1: CGFloat = 0
		var alpha1: CGFloat = 0

		var red2: CGFloat = 0
		var green2: CGFloat = 0
		var blue2: CGFloat = 0
		var alpha2: CGFloat = 0

		getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
		color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

		return Self(
			red: red1 * CGFloat(1.0 - amount) + red2 * amount,
			green: green1 * CGFloat(1.0 - amount) + green2 * amount,
			blue: blue1 * CGFloat(1.0 - amount) + blue2 * amount,
			alpha: alpha1
		)
	}

	func lighter(by amount: CGFloat = 0.2) -> Self { mix(with: .white, amount: amount) }
	func darker(by amount: CGFloat = 0.2) -> Self { mix(with: .black, amount: amount) }
}
*/
