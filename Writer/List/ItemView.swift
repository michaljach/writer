//
//  ItemView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var item: Item
    
    var body: some View {
        let split = item.content?.components(separatedBy: CharacterSet.newlines)
        
        VStack(alignment: .leading, spacing: 0) {
            Text(clearTags(text: split?[0] ?? ""))
                .fontWeight(.semibold)
                .font(.system(size: 16))
                .lineLimit(1)
            Spacer()
            Text(clearTags(text: split?.dropFirst().joined(separator: "\n") ?? ""))
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 24)
        .padding(.vertical, 18)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("DividerColor")), alignment: .bottom)
    }
    
    func clearTags(text: String) -> String {
        return text
            .replacingOccurrences(of: "# ", with: "")
            .replacingOccurrences(of: "**", with: "")
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item())
    }
}

