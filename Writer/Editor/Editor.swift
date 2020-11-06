//
//  Editor.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI

struct Editor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var text: String = ""
    @State private var item: Item?
    
    
    var body: some View {
        EditorView(text: $text, highlightRules: EditorView.markdown, onTextChange: { text in
            viewContext.performAndWait {
                let split = text.components(separatedBy: CharacterSet.newlines)
                item?.title = split[0]
                item?.content = split.dropFirst().joined(separator: "\n")
                try? viewContext.save()
            }
        })
        .defaultInset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        .onAppear {
            item = Item(context: viewContext)
            item!.timestamp = Date()
            item!.title = "title"
            item!.content = text
        }
    }
}

struct Editor_Previews: PreviewProvider {
    static var previews: some View {
        Editor()
    }
}
