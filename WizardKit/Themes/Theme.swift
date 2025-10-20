//
//  Theme.swift
//  Board Game Wizard
//
//  Created by Ahmed El-Khuffash on 2025-10-19.
//

//
//  Theme.swift
//  WidgetWizardKit
//
//  Created by Ahmed El-Khuffash on 2020-09-11.
//

import Foundation
import SwiftUI



public class Theme: ObservableObject {
    
    public static var shared:Theme = Theme()
    
    @Published public var dark:ThemeColors
    @Published public var light:ThemeColors
    
    public static var defaultDark = [
        "accentColor": "FB4D00FF",
        "primaryColor": "FFFFFFFF",
        "secondaryColor": "8a8a8eFF",
        "backgroundColor": "2C2C2CFF"
    ]
    
    public static var defaultLight = [
        "accentColor": "FB4D00FF",
        "primaryColor": "000000FF",
        "secondaryColor": "8a8a8eFF",
        "backgroundColor": "FFFFFFFF"
    ]


    private init() {
        
        self.dark = ThemeColors(from: Theme.defaultDark, isDark: true)
        self.light = ThemeColors(from: Theme.defaultLight, isDark: false)

        self.initColours()
    }
    
    public func resetDarkTheme() {
        self.dark = ThemeColors(from: Theme.defaultDark, isDark: true)
        UserSettings.shared.darkTheme = self.dark.description
    }
    
    public func resetLightTheme() {
        self.light = ThemeColors(from: Theme.defaultLight, isDark: true)
        UserSettings.shared.lightTheme = self.light.description
    }

    
    public func setColors(dark: [String : String], light:[String : String]) {
        
        self.dark = ThemeColors(from: dark, isDark: true)
        self.light = ThemeColors(from: light, isDark: false)

        self.initColours()

    }
    
    
    public func initColours() {
        //print("Theme.initColours")
        
        

        Color.themeAccent = Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? self.dark.accentColor.uiColor : self.light.accentColor.uiColor
        })
        
        Color.themePrimary = Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? self.dark.primaryColor.uiColor : self.light.primaryColor.uiColor
        })

        Color.themeSecondary = Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? self.dark.secondaryColor.uiColor : self.light.secondaryColor.uiColor
        })

        Color.themeBackground = Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? self.dark.backgroundColor.uiColor : self.light.backgroundColor.uiColor
        })
        
        

////        //hide the separators and background in lists and forms
////        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = UIColor(Color.themeAccent)

        UITableView.appearance().backgroundColor = UIColor(Color.pink)

        //UITableViewCell.appearance().backgroundColor = UIColor(Color.themeBackground)


        UISegmentedControl.appearance().backgroundColor = UIColor(Color.themeBackground)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.themeAccent)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.themePrimary).inverse() ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.themePrimary)], for: .normal)
        
        //UIListContentView.appearance().backgroundColor = UIColor(Color.backgroundColor)
        
        //supposed iOS 15 fix
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.themeBackground)
//        UINavigationBar.appearance().standardAppearance = appearance;
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        

        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()

        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(Color.themeAccent)
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(Color.themeAccent)
        ]



        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        // This property is not present on the UINavigationBarAppearance
        // object for some reason and you have to leave it til the end
        UINavigationBar.appearance().tintColor = UIColor(Color.themeAccent)
    
        let tabBarAppearance = UITabBarAppearance()
        
        if #available(iOS 15.0, *) {
            //print("I AM HERE OH LORD I AM HERE!")
            tabBarAppearance.backgroundColor = UIColor(Color.themeBackground)
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        UITabBar.appearance().barTintColor = UIColor(Color.themeBackground)
        UITabBar.appearance().tintColor = UIColor(Color.themePrimary)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.themeSecondary)
        
        
        UITabBar.appearance().standardAppearance.backgroundColor = UIColor(Color.themeBackground)


    }
}

public class ThemeColors:ObservableObject, Equatable {
    
    
    @Published public var accentColor:Color
    @Published public var primaryColor:Color
    @Published public var secondaryColor:Color
    @Published public var backgroundColor:Color
    
    @Published public var isDark:Bool
    
    public var description:[String : String]  {
        
        return ["accentColor": accentColor.uiColor.toHex!,
        "primaryColor": primaryColor.uiColor.toHex!,
        "secondaryColor": secondaryColor.uiColor.toHex!,
        "backgroundColor": backgroundColor.uiColor.toHex!
        ]


    }
    
    public init(from theme:[String : String], isDark:Bool) {
        accentColor = Color( UIColor.init(hex: theme["accentColor"]! )! )
        primaryColor = Color( UIColor.init(hex: theme["primaryColor"]! )! )
        secondaryColor = Color( UIColor.init(hex: theme["secondaryColor"]! )! )
        backgroundColor = Color( UIColor.init(hex: theme["backgroundColor"]! )! )
        
        self.isDark = isDark
    }
    
    public static func == (lhs: ThemeColors, rhs: ThemeColors) -> Bool {
        if lhs.accentColor == rhs.accentColor &&
            lhs.primaryColor == rhs.primaryColor &&
            lhs.secondaryColor == rhs.secondaryColor &&
            lhs.backgroundColor == rhs.backgroundColor {
            return true
        } else {
            return false
        }
    }
    
    public func saveToUserDefaults(isDark:Bool) {
        if isDark {
            UserSettings.shared.darkTheme = self.description
        } else {
            UserSettings.shared.lightTheme = self.description
        }
        
    }

}

extension Color {
    public static var themeAccent:Color = Color.main
    public static var themePrimary:Color = Color.primary
    public static var themeSecondary:Color = Color.secondary
    public static var themeBackground:Color = Color.backgroundColor
}
