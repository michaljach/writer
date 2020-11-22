//
//  ToolbarView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: Editor().navigationBarTitle("", displayMode: .inline)) {
                Image("add")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("AccentColor"))
            }
        }
        .padding()
        .background(Color("BackgroundColor"))
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
