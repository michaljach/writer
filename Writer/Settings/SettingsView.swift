//
//  SettingsView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    
    @State private var spinnerVisible = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Section(header: HeaderView(title: "Editor")) {
                            VStack(spacing: 0) {
                                NavigationLink(destination: TypographySettingsView()) {
                                    SettingsNavItemView(title: "Typography", current: {
                                        Image("arrow_right")
                                    }) {
                                        
                                    }
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                }
                                
                                SettingsNavItemView(title: "Start with heading", current: {
                                    Toggle("", isOn: $settings.heading).frame(width: 60, height: 10, alignment: .center)
                                }) {
                                    
                                }
                                .padding()
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                
                                SettingsNavItemView(title: "Default Space", current: {
                                    HStack {
                                        Text("All")
                                        Image("arrow_right")
                                    }
                                }) {
                                    
                                }
                                .padding()
                                .opacity(0.2)
                            }
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                        
                        Section(header: HeaderView(title: "Look and feel")) {
                            VStack(spacing: 0) {
                                NavigationLink(destination: IconSettingsView()) {
                                    SettingsNavItemView(title: "App Icon", current: {
                                        Image("arrow_right")
                                    }) {
                                        
                                    }
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                }
                                
                                SettingsNavItemView(title: "Themes", current: {
                                    EmptyView()
                                }) {
                                    
                                }
                                .padding()
                                .opacity(0.2)
                            }
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                        
                        Section(header: HeaderView(title: "Writer")) {
                            VStack(spacing: 0) {
                                SettingsItemView(title: "Version", current: Text(WriterApp.appVersion!))
                                    .padding()
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                                
                                SettingsNavItemView(title: "Request a feature", current: {
                                    Image("arrow_right")
                                }) {
                                    
                                }
                                .padding()
                                .background(Color("SelectionColor"))
                                .onTapGesture {
                                    if let url = URL(string: "https://writer.kampsite.co") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                
                                if !UserDefaults.standard.bool(forKey: "com.mj.Writer.FullVersionOneTime") {
                                    NavigationLink(destination: GetFullVersionView()) {
                                        SettingsNavItemView(title: "Get full version", current: {
                                            Image("arrow_right")
                                        }) {
                                            
                                        }
                                        .padding()
                                        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerDarkColor")), alignment: .top)
                                    }
                                }
                                
                                Button(action: {
                                    spinnerVisible = true
                                    storeManager.restoreProducts(callback: {
                                        spinnerVisible = false
                                    })
                                }, label: {
                                    HStack {
                                        Text("Restore purchases")
                                            .fontWeight(.medium)
                                        Spacer()
                                        ProgressView()
                                            .opacity(spinnerVisible ? 1 : 0)
                                    }
                                })
                                .padding()
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerDarkColor")), alignment: .top)
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
                    self.presentationMode.wrappedValue.dismiss()
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

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .preferredColorScheme(.dark)
//            .environmentObject(UserSettings())
//    }
//}
