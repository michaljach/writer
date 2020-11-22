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
    
    var body: some View {
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
        .onAppear {
            guard let content = item?.content else { return }
            self.text = content
        }
    }
}

struct Editor_Previews: PreviewProvider {
    static var previews: some View {
        Editor()
            .preferredColorScheme(.dark)
    }
}
