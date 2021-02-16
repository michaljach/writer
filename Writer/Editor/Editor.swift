//
//  Editor.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI
import WidgetKit

struct Editor: View {
    @EnvironmentObject var settings: UserSettings
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var text: String = "# "
    @State var item: Item?
    @State private var favouriteIcon = false
    @State private var bookmarkIcon = false
    @State private var isPresented = false
    
    
    var fetchMenuRequest = FetchRequest<Folder>(entity: Folder.entity(), sortDescriptors: [])
    
    var body: some View {
        VStack(spacing: 0) {
            EditorView(text: $text, isFirstResponder: item == nil, highlightRules: EditorView.markdown(fontFace: settings.fontFace, fontSize: settings.fontSize), onTextChange: { text in
                viewContext.performAndWait {
                    if let item = item {
                        let timestamp = Date()
                        item.timestamp = timestamp
                        item.content = text
                        if bookmarkIcon {
                            if let userDefaults = UserDefaults(suiteName: "group.com.mj.Writer") {
                                userDefaults.set(String((timestamp.timeIntervalSince1970)), forKey: "widgetItemId")
                                userDefaults.set(text as AnyObject, forKey: "widgetItem")
                                userDefaults.synchronize()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        }
                        try? viewContext.save()
                    } else {
                        item = Item(context: viewContext)
                        item?.timestamp = Date()
                        item?.content = text
                        if settings.selectedFolder == "favourites" {
                            item?.isFavourited = true
                        } else if settings.selectedFolder != "all" {
                            if let found = fetchMenuRequest.wrappedValue.first(where: { $0.id == settings.selectedFolder }) {
                                item?.addToFolders(found)
                            }
                        }
                        
                    }
                }
            })
            .defaultInset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            .onAppear {
                
                if let content = item?.content {
                    self.text = content
                    if let item = item {
                        favouriteIcon = item.isFavourited
                        if let userDefaults = UserDefaults(suiteName: "group.com.mj.Writer") {
                            let timestamp = userDefaults.string(forKey: "widgetItemId")
                            if timestamp == String(item.timestamp?.timeIntervalSince1970 ?? 0) {
                                bookmarkIcon = true
                            } else {
                                bookmarkIcon = false
                            }
                        }
                    }
                } else {
                    self.text = settings.heading ? "# " : ""
                    favouriteIcon = false
                    
                }
            }
            .navigationBarItems(trailing: trailingBarItems)
            .navigationBarTitle("", displayMode: .inline)
            
            HStack(spacing: 0) {
                //                Button(action: {
                //                    keyboardAction(type: "bold")
                //                }) {
                //                    Image("bold")
                //                        .resizable()
                //                        .frame(width: 24, height: 24, alignment: .center)
                //                        .foregroundColor(Color("AccentColor"))
                //                        .padding(.vertical)
                //                }
                //                .padding(.horizontal, 8)
                //
                //                Button(action: {
                //
                //                }) {
                //                    Image("italic")
                //                        .resizable()
                //                        .frame(width: 24, height: 24, alignment: .center)
                //                        .foregroundColor(Color("AccentColor"))
                //                        .padding(.vertical)
                //                }
                //                .padding(.horizontal, 8)
                //
                //                Button(action: {
                //
                //                }) {
                //                    Image("strikethrough")
                //                        .resizable()
                //                        .frame(width: 24, height: 24, alignment: .center)
                //                        .foregroundColor(Color("AccentColor"))
                //                        .padding(.vertical)
                //                }
                //                .padding(.horizontal, 8)
                //
                //                Button(action: {
                //
                //                }) {
                //                    Image("underline")
                //                        .resizable()
                //                        .frame(width: 24, height: 24, alignment: .center)
                //                        .foregroundColor(Color("AccentColor"))
                //                        .padding(.vertical)
                //                }
                //                .padding(.horizontal, 8)
                //
                //                Button(action: {
                //
                //                }) {
                //                    Image("blockquote")
                //                        .resizable()
                //                        .frame(width: 24, height: 24, alignment: .center)
                //                        .foregroundColor(Color("AccentColor"))
                //                        .padding(.vertical)
                //                }
                
                Spacer()
                
                Button(action: {
                    keyboardAction(type: "hideKeyboard")
                }) {
                    Image("arrow_down")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
        }
        .sheet(isPresented: $isPresented, content: {
            MoveToFolderView(note: item)
        })
    }
    
    func keyboardAction(type: String) {
        switch type {
        case "bold":
            return
        case "hideKeyboard":
            UIApplication.shared.endEditing()
        default:
            return
        }
    }
    
    var trailingBarItems: some View {
        HStack(spacing: 16) {
            if item?.isBin ?? false {
                Button(action: {
                    item?.isBin = false
                    try! viewContext.save()
                }) {
                    Image("box")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
            } else {
                Button(action: {
                    isPresented.toggle()
                }) {
                    Image("folder")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                Button(action: {
                    if let userDefaults = UserDefaults(suiteName: "group.com.mj.Writer") {
                        userDefaults.set(item?.content as AnyObject, forKey: "widgetItem")
                        userDefaults.set(String((item?.timestamp?.timeIntervalSince1970)!), forKey: "widgetItemId")
                        userDefaults.synchronize()
                        WidgetCenter.shared.reloadAllTimelines()
                        bookmarkIcon.toggle()
                    }
                }) {
                    Image(bookmarkIcon ? "pin_filled" : "pin")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                Button(action: {
                    item?.isFavourited.toggle()
                    favouriteIcon.toggle()
                    try! viewContext.save()
                }) {
                    Image(favouriteIcon ? "heart_filled" : "heart")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
            }
        }
    }
}

struct Editor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Editor()
                .preferredColorScheme(.dark)
                .environmentObject(UserSettings())
        }
    }
}
