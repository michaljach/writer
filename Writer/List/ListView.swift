//
//  ContentView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI
import CoreData

struct ListView: View  {
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var storeManager: StoreManager
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color("AccentColor"))]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("AccentColor"))]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = UIColor(Color("AccentColor"))
        
        UITableView.appearance().backgroundColor = UIColor(Color("BackgroundColor"))
    }
    
    var body: some View {
        NavigationView {
            MenuView()
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
                .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: logoButton)
            
            NotesListView(filter: settings.selectedFolder)
                .environmentObject(settings)
            
            Editor()
                .navigationBarTitle("", displayMode: .inline)
                .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
        }
    }
    
    var logoButton: some View {
        Button(action: {
            
        }) {
            Image("logo")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(Color("AccentColor"))
                .padding(.vertical)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
