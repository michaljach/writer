//
//  MenuView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Section(header: HeaderView(title: "Notes")) {
                        MenuItemView(title: "All", iconName: "box", active: true)
                        MenuItemView(title: "Favourites", iconName: "heart", active: false)
                        MenuItemView(title: "Bin", iconName: "bin", active: false)
                    }
                    
                    Section(header: HeaderView(title: "Spaces")) {
                        MenuItemView(title: "Finance", iconName: "folder", active: false)
                        MenuItemView(title: "Personal", iconName: "folder", active: false)
                        MenuItemView(title: "Games", iconName: "folder", active: false)
                    }
                }
                .padding()
            }
            
            Spacer()
            MenuToolbarView()
        }
        .background(Color.clear)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(Rectangle().frame(width: 1, height: nil, alignment: .trailing).foregroundColor(Color("DividerColor")), alignment: .trailing)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
