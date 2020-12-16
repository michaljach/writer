//
//  TypographySettings.swift
//  Writer
//
//  Created by Michal Jach on 04/12/2020.
//

import SwiftUI

struct IconSettingsView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Section(header: HeaderView(title: "Select homescreen app icon")) {
                        VStack(spacing: 0) {
                            SettingsNavItemView(title: "Default", current: {
                                settings.icon == "default" ? Image("tick") : Image("")
                            }) {
                                
                            }
                            .padding()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                            .background(Color("SelectionColor"))
                            .onTapGesture {
                                settings.icon = "default"
                                UIApplication.shared.setAlternateIconName(nil)
                            }
                            
                            SettingsNavItemView(title: "Dark", current: {
                                settings.icon == "dark" ? Image("tick") : Image("")
                            }) {
                                
                            }
                            .padding()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                            .background(Color("SelectionColor"))
                            .onTapGesture {
                                settings.icon = "dark"
                                UIApplication.shared.setAlternateIconName("icon_dark") { error in
                                    
                                }
                            }
                            
                            SettingsNavItemView(title: "Grey", current: {
                                settings.icon == "grey" ? Image("tick") : Image("")
                            }) {
                                
                            }
                            .padding()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                            .background(Color("SelectionColor"))
                            .onTapGesture {
                                settings.icon = "grey"
                                UIApplication.shared.setAlternateIconName("icon_grey") { error in
                                    
                                }
                            }
                            
                            SettingsNavItemView(title: "Aqua", current: {
                                settings.icon == "aqua" ? Image("tick") : Image("")
                            }) {
                                
                            }
                            .padding()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                            .background(Color("SelectionColor"))
                            .onTapGesture {
                                settings.icon = "aqua"
                                UIApplication.shared.setAlternateIconName("icon_aqua") { error in
                                    
                                }
                            }
                        }
                        .background(Color("SelectionColor"))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .navigationBarTitle("Settings", displayMode: .inline)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
            }
        }
    }
}

struct IconSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        IconSettingsView()
    }
}

