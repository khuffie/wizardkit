//
//  MainTextHeader.swift
//  WidgetWizardKit
//
//  Created by Ahmed El-Khuffash on 2021-10-31.
//

import SwiftUI


public struct MainTextHeaderView: View {
    
    var text:String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.themeAccent)
                //.headerFontWeight()
                .font(.headline)
            Spacer()

        }
    }
}


