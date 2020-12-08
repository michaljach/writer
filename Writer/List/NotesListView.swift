//
//  NotesListView.swift
//  Writer
//
//  Created by Michal Jach on 13/11/2020.
//

import SwiftUI

struct NotesListView: View {
    @State private var selectedItem: Item?
    private var selectedMenu = "all"
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var settings: UserSettings
    
    var fetchRequest: FetchRequest<Item>
    
    init(filter: String) {
        if filter != "all" {
            fetchRequest = FetchRequest<Item>(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)], predicate: NSPredicate(format: "content CONTAINS %@", filter))
        } else {
            fetchRequest = FetchRequest<Item>(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)])
        }
        UITableView.appearance().backgroundColor = UIColor(Color("BackgroundColor"))
        UITableViewCell.appearance().selectionStyle = .none
        
        selectedMenu = filter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                ForEach(fetchRequest.wrappedValue) { (item) in
                    ZStack {
                        ItemView(item: item)
                        NavigationLink(destination: Editor(item: item).navigationBarTitle("", displayMode: .inline).background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)), tag: item, selection: self.$selectedItem) {
                            EmptyView()
                        }
                        .opacity(0)
                        .onTapGesture {
                            self.selectedItem = item
                        }
                        
                    }
                    .listRowBackground(self.selectedItem == item ? Color("SelectionColor").edgesIgnoringSafeArea(.all) : Color("BackgroundColor").edgesIgnoringSafeArea(.all))
                    .listRowInsets(EdgeInsets())
                }
                .onDelete(perform: onDelete)
            }
            .listStyle(PlainListStyle())
            .background(Color("BackgroundColor"))
            .animation(.default)
            
            ToolbarView()
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
        }
        .padding(0)
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
        .navigationBarTitle("Notes", displayMode: .inline)
        .navigationBarItems(trailing: trailingNavigationItems)
        .onAppear {
            settings.selectedFolder = selectedMenu

            if settings.firstLaunch {
                settings.firstLaunch = false
                settings.createOnboardingData(viewContext: viewContext)
            }
        }
    }
    
    var trailingNavigationItems: some View {
        Button(action: {
            
        }) {
            Image("search")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(Color("AccentColor"))
                .padding(.vertical)
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        withAnimation {
            offsets.map { fetchRequest.wrappedValue[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(UserSettings())
    }
}
