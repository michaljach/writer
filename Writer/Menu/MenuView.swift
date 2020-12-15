//
//  MenuView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var settings: UserSettings
    
    var menuItems = [
        SystemMenuItem(icon: "box", id: "all", title: "All"),
        SystemMenuItem(icon: "heart", id: "favourites", title: "Favourites"),
        SystemMenuItem(icon: "bin", id: "bin", title: "Bin")
    ]
    
    var fetchRequest = FetchRequest<Folder>(entity: Folder.entity(), sortDescriptors: [])
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Section(header: HeaderView(title: "Notes").padding(.bottom)) {
                        ForEach(menuItems) { (systemMenuItem) in
                            NavigationLink(destination: NotesListView(filter: systemMenuItem.id)) {
                                MenuItemView(title: systemMenuItem.title, iconName: systemMenuItem.icon, active: settings.selectedFolder == systemMenuItem.id)
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                settings.selectedFolder = systemMenuItem.id
                            })
                        }
                    }
                    
                    Section(header: HeaderView(title: "Folders").padding(.bottom)) {
                        ForEach(fetchRequest.wrappedValue) { (systemMenuItem) in
                            NavigationLink(destination: NotesListView(filter: systemMenuItem.id!)) {
                                MenuItemView(title: systemMenuItem.title!, iconName: "folder", active: settings.selectedFolder == systemMenuItem.id)
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                if let found = fetchRequest.wrappedValue.first(where: { $0.id == systemMenuItem.id }) {
                                    settings.selectedFolder = found.id ?? "all"
                                }
                            })
                        }
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
            .environmentObject(UserSettings())
    }
}
