//
//  SettingsColorView.swift
//  Widget Wizard
//
//  Created by Ahmed El-Khuffash on 2020-08-23.
//

import SwiftUI

/*
public struct ThemeSettingsView: View {
    
    @StateObject var theme = Theme.shared
    @Environment(\.scenePhase) private var scenePhase

    public init() {
    }

    
    public var body: some View {
        ScrollView {

            VStack {

                MainTextHeaderView(text: "Theme Settings")
                   


                
                VStack {
                    HStack {
                        Image(systemName: "eyedropper")
                            .foregroundColor(.themeAccent)
                        Text("Light Theme")
                            .foregroundColor(.themeAccent)
                            .textCase(.uppercase)
                            .font(.footnote)
                        Spacer()
                    }
                    
                    HStack {
                        VStack{
                            ColorPicker("", selection: $theme.light.accentColor)
                                .labelsHidden()

                            Text("Accent")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                        
                        /*
                        VStack {
                            ColorPicker("", selection: $theme.light.primaryColor)
                                .labelsHidden()
                            Text("Primary")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                        VStack {
                            ColorPicker("", selection: $theme.light.secondaryColor)
                                .labelsHidden()
                            Text("Secondary")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                        */
                        VStack {
                            
                            ColorPicker("", selection: $theme.light.backgroundColor, supportsOpacity: false)
                                .labelsHidden()
                            Text("Background")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                    }
                    
                    
                }.listRowBackground(Color.themeBackground)
                .padding([.top,.bottom])
                
                VStack {
                    HStack {
                        Image(systemName: "eyedropper")
                            .foregroundColor(.themeAccent)
                        Text("Dark Theme")
                            .foregroundColor(.themeAccent)
                            .textCase(.uppercase)
                            .font(.footnote)
                        Spacer()
                    }
                    
                    HStack {
                        VStack {
                            ColorPicker("", selection: $theme.dark.accentColor)
                                .labelsHidden()
                                .onChange(of: theme.dark){ oldValue, value in
                                    print("wee")
                                }
                            Text("Accent")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                        
                        /*
                        VStack {
                            ColorPicker("", selection: $theme.dark.primaryColor)
                                .labelsHidden()
                            Text("Primary")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                        VStack{
                            ColorPicker("", selection: $theme.dark.secondaryColor)
                                .labelsHidden()
                            Text("Secondary")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                         */
                        VStack {
                            ColorPicker("", selection: $theme.dark.backgroundColor, supportsOpacity: false)
                                .labelsHidden()
                            Text("Background")
                                .font(.caption2)
                        }.frame(minWidth: 60)
                        
                        
                    }
                    
                

                }
                .listRowBackground(Color.themeBackground)
                .padding([.top,.bottom])
                

                


                VStack {
                    Button(action : { self.theme.resetLightTheme() }) {
                        
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.themeAccent)
                            Text("Reset Light Theme")
                                .foregroundColor(.themeAccent)
                                .textCase(.uppercase)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                    
                    
                }.listRowBackground(Color.themeBackground)
                
                .padding([.top,.bottom])

                VStack {
                    Button(action : {
                        self.theme.resetDarkTheme()
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.themeAccent)
                            Text("Reset Dark Theme")
                                .foregroundColor(.themeAccent)
                                .textCase(.uppercase)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                }.listRowBackground(Color.themeBackground)
                
                .padding([.top,.bottom])
            }
            .padding()
            .padding(.top, 5)
            
            .onAppear {
            }
            .onDisappear {
                self.theme.dark.saveToUserDefaults(isDark: true)
                self.theme.light.saveToUserDefaults(isDark: false)
            }
            .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .background  {
                    self.theme.dark.saveToUserDefaults(isDark: true)
                    self.theme.light.saveToUserDefaults(isDark: false)
                }
            }
            
            
        }
        .background(Color.backgroundColor)
        //.navigationBarTitle("Colors")
        

    }
}

*/
