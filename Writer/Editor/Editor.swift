//
//  Editor.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI

struct Editor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var text: String = "# "
    @State var item: Item?
    
    @State private var textView: UITextView?
    
    var body: some View {
        VStack {
            EditorView(text: $text, highlightRules: EditorView.markdown, onTextChange: { text in
                viewContext.performAndWait {
                    if let item = item {
                        item.timestamp = Date()
                        item.content = text
                        try? viewContext.save()
                    } else {
                        item = Item(context: viewContext)
                        item!.timestamp = Date()
                        item!.content = text
                    }
                }
            })
            .defaultInset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            .onInit { textView in
                if item == nil {
                    self.textView = textView
                    textView.becomeFirstResponder()
                    textView.backgroundColor = UIColor(Color("BackgroundColor"))
                    textView.autocapitalizationType = .allCharacters
                }
            }
            .onAppear {
                guard let content = item?.content else { return }
                self.text = content
            }
            .navigationBarItems(trailing: trailingBarItems)
            .navigationBarTitle("", displayMode: .inline)
            
            HStack {
                Button(action: {
                    keyboardAction(type: "bold")
                }) {
                    Image("bold")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                .padding(.horizontal, 8)
                
                Button(action: {
                    
                }) {
                    Image("italic")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                .padding(.horizontal, 8)
                
                Button(action: {
                    
                }) {
                    Image("strikethrough")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                .padding(.horizontal, 8)
                
                Button(action: {
                    
                }) {
                    Image("underline")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                .padding(.horizontal, 8)
                
                Button(action: {
                    
                }) {
                    Image("blockquote")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical)
                }
                
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
        }
    }
    
    func keyboardAction(type: String) {
        switch type {
        case "bold":
            return
        case "hideKeyboard":
            textView?.resignFirstResponder()
            textView?.endEditing(true)
        default:
            return
        }
    }
    
    var trailingBarItems: some View {
        HStack(spacing: 16) {
            Button(action: {
                
            }) {
                Image("folder")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical)
            }
            Button(action: {
                
            }) {
                Image("pin")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical)
            }
            Button(action: {
                
            }) {
                Image("heart")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical)
            }
        }
    }
}

struct Editor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Editor()
                .preferredColorScheme(.dark)
        }
    }
}
