//
//  MenuView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var globalMenu: GlobalMenu
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Section(header: HeaderView(title: "Notes")) {
                        NavigationLink(destination: NotesListView(filter: "all")) {
                            MenuItemView(title: "All", iconName: "box", active: settings.selectedFolder == "all")
                        }
                        
                        NavigationLink(destination: NotesListView(filter: "bin")) {
                            MenuItemView(title: "Bin", iconName: "bin", active: settings.selectedFolder == "bin")
                        }
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
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
