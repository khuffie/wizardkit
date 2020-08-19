//
//  Checkbox.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-07-17.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import SwiftUI

public struct Checkbox: View {
	
	
	@State public var isChecked:Bool = false
	var id: String = ""
	let callback: (String, Bool)->()
	//let isCheckedInternal:Bool

	public init(isChecked: Bool, id: String, callback: @escaping (String, Bool) -> ()) {
		self.id = id
		self.callback = callback
		self._isChecked = State(initialValue: isChecked)
		//self.isChecked = self.isCheckedInternal
	}

	

	public var body: some View {
		Button(action: {
			self.isChecked.toggle()
			self.callback(self.id, self.isChecked)
		}){
			HStack{
				Image(systemName: isChecked ? "largecircle.fill.circle": "circle")
			}
		}
	}
	

}
