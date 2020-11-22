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
                        NavigationLink(
                            destination: NotesListView(),
                            label: {
                                MenuItemView(title: "All", iconName: "box", active: true)
                            })
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
        .background(Color("BackgroundColor"))
//        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
