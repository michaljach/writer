//
//  SettingsView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Section(header: HeaderView(title: "Editor")) {
                            VStack(spacing: 0) {
                                SettingsNavItemView(title: "Typography", current: nil) {
                                    
                                }
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                
                                
                                SettingsNavItemView(title: "Start note with", current: Text("Heading")) {
                                    
                                }
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                
                                SettingsNavItemView(title: "Default Space", current: Text("All")) {
                                    
                                }
                                    .padding()
                            }
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                        
                        Section(header: HeaderView(title: "Look and feel")) {
                            VStack(spacing: 0) {
                                SettingsNavItemView(title: "App Icons", current: nil) {
                                    
                                }
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                
                                SettingsNavItemView(title: "Themes", current: Text("Raven")) {
                                    
                                }
                                    .padding()
                            }
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                        
                        Section(header: HeaderView(title: "Writer")) {
                            VStack(spacing: 0) {
                                SettingsItemView(title: "Version", current: Text(WriterApp.appVersion!))
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                
                                SettingsItemView(title: "Request feature", current: nil)
                                    .padding()
                            }
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    
                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    self.showSettings.toggle()
                }, label: {
                    Image("close")
                        .resizable()
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: 24, height: 24, alignment: .center)
                }))
                .navigationBarTitle("Settings", displayMode: .inline)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(true))
            .preferredColorScheme(.dark)
    }
}
