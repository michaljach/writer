//
//  TypographySettings.swift
//  Writer
//
//  Created by Michal Jach on 04/12/2020.
//

import SwiftUI

struct TypographySettingsView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State private var text: String = "# This is example note\nHello from **Typography Settings** screen. This preview shows **bold** text as well as *italic* and ~striked out~.\n\n> You can also see a highlight.\n\n#nice #lovewriter "
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Section(header: HeaderView(title: "Select your preferred font face")) {
                        VStack(spacing: 0) {
                            SettingsNavItemView(title: "Default", current: {
                                settings.fontFace == "default" ? Image("tick") : Image("")
                            }) {
                                
                            }
                            .padding()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                            .background(Color("SelectionColor"))
                            .onTapGesture {
                                settings.fontFace = "default"
                            }
                            
                            SettingsNavItemView(title: "Monospace", current: {
                                settings.fontFace == "monospace" ? Image("tick") : Image("")
                            }) {
                                
                            }
                            .padding()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerDarkColor")), alignment: .bottom)
                            .background(Color("SelectionColor"))
                            .onTapGesture {
                                settings.fontFace = "monospace"
                            }
                            
                        }
                        .background(Color("SelectionColor"))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Section(header: HeaderView(title: "Select font size")) {
                        VStack(spacing: 0) {
                            Slider(value: $settings.fontSize, in: 8...20, step: 2)
                            HStack {
                                Text("Smaller")
                                    .fontWeight(.medium)
                                Spacer()
                                Text("Bigger")
                                    .fontWeight(.medium)
                            }
                            .padding(.top)
                        }
                        .padding()
                        .background(Color("SelectionColor"))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Section(header: HeaderView(title: "Preview")) {
                        VStack(spacing: 0) {
                            EditorView(text: $text, isFirstResponder: false, highlightRules: EditorView.markdown(fontFace: settings.fontFace, fontSize: settings.fontSize), onTextChange: { text in
                                
                            })
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300, alignment: .topLeading)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        }
                        .background(Color("SelectionColor"))
                        .cornerRadius(12)
                        .padding(.vertical)
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

struct TypographySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TypographySettingsView()
            .environmentObject(UserSettings())
            
    }
}

