//
//  MenuToolbarView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct MenuToolbarView: View {
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var settings: UserSettings
    @State var showSettings = false
    @State var showFolders = false
    
    enum Sheet: Hashable, Identifiable {
        case a
        case b
        
        var id: Int {
            return self.hashValue
        }
    }
    
    @State var activeSheet: Sheet? = nil
    
    var body: some View {
        HStack {
            Button(action: {
                self.activeSheet = .a
            }, label: {
                Image("settings")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("DimmedColor"))
            })
            
            Spacer()
            Button(action: {
                self.activeSheet = .b
            }, label: {
                Image("plus")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("DimmedColor"))
            })
            .sheet(isPresented: $showFolders, content: {
                AddFolderView()
            })
        }
        .padding()
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
        .background(EmptyView().sheet(isPresented: $showFolders) {
            AddFolderView()
        })
        .sheet(item: $activeSheet) { item in
            if item == .a {
                SettingsView()
                    .environmentObject(settings)
            } else if item == .b {
                AddFolderView()
            }
        }
    }
}

struct MenuToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuToolbarView()
    }
}
