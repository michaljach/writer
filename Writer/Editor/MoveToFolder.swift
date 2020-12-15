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
                        Section(header: HeaderView(title: "Move to one of existing folders")) {
                            VStack {
                                ForEach(fetchRequest.wrappedValue) { item in
                                        MenuItemView(title: item.title!, iconName: "folder", active: false)
                                            .background(Color("SelectionColor"))
                                            .onTapGesture {
                                                note?.folders = []
                                                note?.addToFolders(item)
                                                try! viewContext.save()
                                                self.presentationMode.wrappedValue.dismiss()
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
