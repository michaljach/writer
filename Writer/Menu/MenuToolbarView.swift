//
//  MenuToolbarView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct MenuToolbarView: View {
    @State var showSettings = false
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showSettings.toggle()
            }, label: {
                Image("settings")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("DimmedColor"))
            })
        }
        .padding()
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
        .sheet(isPresented: $showSettings, content: {
            SettingsView(showSettings: self.$showSettings)
        })
    }
}

struct MenuToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuToolbarView()
    }
}
