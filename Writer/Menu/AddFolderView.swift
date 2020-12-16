//
//  AddFolderView.swift
//  Writer
//
//  Created by Michal Jach on 09/12/2020.
//

import SwiftUI

struct AddFolderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var folderName = ""
    
    var fetchRequest = FetchRequest<Folder>(entity: Folder.entity(), sortDescriptors: [])
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Section(header: HeaderView(title: "Add new folder")) {
                            VStack {
                                TextField("Enter folder name", text: $folderName)
                                
                            }
                            .padding()
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                        
                        Button(action: {
                            let folder = Folder(context: viewContext)
                            folder.id = folderName.lowercased()
                            folder.title = folderName
                            try! viewContext.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Add")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("SelectionColor"))
                                .cornerRadius(12)
                                .font(.headline)
                        }
                        
                        Section(header: HeaderView(title: "Existing folders")) {
                            VStack {
                                if fetchRequest.wrappedValue.isEmpty {
                                    VStack {
                                        Text("No folders created.")
                                            .padding()
                                            .opacity(0.3)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color("SelectionColor"))
                                    .cornerRadius(12)
                                } else {
                                    ForEach(fetchRequest.wrappedValue) { item in
                                        HStack {
                                            MenuItemView(title: item.title!, iconName: "folder", active: false)
                                            
                                            Button(action: {
                                                withAnimation {
                                                    viewContext.delete(item)
                                                    
                                                    do {
                                                        try viewContext.save()
                                                    } catch {
                                                        // Replace this implementation with code to handle the error appropriately.
                                                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                                        let nsError = error as NSError
                                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                                    }
                                                }
                                            }, label: {
                                                Image("bin")
                                                    .resizable()
                                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                    .foregroundColor(Color("DimmedColor"))
                                            })
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                            .background(Color("SelectionColor"))
                            .cornerRadius(12)
                        }
                        
                    }
                    .padding()
                }
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("close")
                        .resizable()
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: 24, height: 24, alignment: .center)
                }))
                .navigationBarTitle("Folders", displayMode: .inline)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
            }
        }
    }
}

struct AddFolderView_Previews: PreviewProvider {
    static var previews: some View {
        AddFolderView()
    }
}
