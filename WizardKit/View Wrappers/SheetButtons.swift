//
//  SheetClosedButton.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-06-10.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import SwiftUI

public struct SheetXButton: View {
	
	@Binding public var isPresented: Bool
	
    public var buttonColor:Color = .main
    
    public init(isPresented: Binding<Bool>, color: Color? = nil ) {
		_isPresented = isPresented
        
        if color != nil {
            buttonColor = color!
        }
	}
	
	public var body: some View {
		
		HStack {
			Spacer()
			Button(action: {
				self.isPresented = false
			}) {
				Image(systemName: "xmark.circle.fill")
					.foregroundColor(buttonColor)
			}
		}

		
    }
}


public struct SheetCloseButton: View {
	
	@Binding var isPresented: Bool
	
	public init(isPresented: Binding<Bool> ) {
		_isPresented = isPresented
	}

	
	public var body: some View {
		
		HStack {
			Spacer()
			Button(action: {
				self.isPresented = false
			}) {
				Text("Close")
					//.primaryButton()
			}
			Spacer()
		}

		
    }
}

struct SheetCloseButton_Previews: PreviewProvider {
    static var previews: some View {
		SheetXButton(isPresented: .constant(true))
    }
}
