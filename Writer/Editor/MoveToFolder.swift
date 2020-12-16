//
//  MoveToFolder.swift
//  Writer
//
//  Created by Michal Jach on 15/12/2020.
//

import SwiftUI

struct MoveToFolderView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    var note: Item?
    var fetchRequest = FetchRequest<Folder>(entity: Folder.entity(), sortDescriptors: [])
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Section(header: HeaderView(title: "Move note to one or more of existing folders")) {
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
                                            Image("folder")
                                                .resizable()
                                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            
                                            Text(item.title!)
                                                .fontWeight(.semibold)
                                            Spacer()
                                            
                                            if let folders = note?.folders {
                                                if folders.contains(item) {
                                                    Image("tick")
                                                }
                                            }
                                        }
                                        .padding(12)
                                        .cornerRadius(12)
                                        .background(Color("SelectionColor"))
                                        .onTapGesture {
                                            if let folders = note?.folders {
                                                if folders.contains(item) {
                                                    note?.removeFromFolders(item)
                                                    try! viewContext.save()
                                                } else {
                                                    note?.addToFolders(item)
                                                    try! viewContext.save()
                                                }
                                            }
                                        }
                                        
//                                        MenuItemView(title: item.title!, iconName: "folder", active: false)
//                                            .background(Color("SelectionColor"))
//                                            .onTapGesture {
//                                                note?.folders = []
//                                                note?.addToFolders(item)
//                                                try! viewContext.save()
//                                                self.presentationMode.wrappedValue.dismiss()
//                                            }
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
                .navigationBarTitle("Move", displayMode: .inline)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
            }
        }
    }
}

struct MoveToFolderView_Previews: PreviewProvider {
    static var previews: some View {
        MoveToFolderView()
    }
}
