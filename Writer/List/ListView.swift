//
//  ContentView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI
import CoreData

struct ListView: View {
    @State var showMenu = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    
    private var items: FetchedResults<Item>
    
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
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading, spacing: 0) {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                ForEach(items) { item in
                                    ItemView(item: item)
                                }
                            }
                        }
                        .disabled(self.showMenu)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarItems(leading: navigationBarView)
                        
                        ToolbarView()
                    }
                    .offset(x: self.showMenu ? geometry.size.width/1.4 : 0)
                    
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/1.4, height: geometry.size.height)
                            .transition(.move(edge: .leading))
                    }
                }
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
                
                .background(Color("BackgroundColor"))
            }
        }
    }
    
    var navigationBarView: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.15)) {
                self.showMenu.toggle()
            }
        }) {
            Image("menu")
                .resizable()
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("AccentColor"))
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
