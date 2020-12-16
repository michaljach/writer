//
//  MenuItemView.swift
//  Writer
//
//  Created by Michal Jach on 05/11/2020.
//

import SwiftUI

struct MenuItemView: View {
    let title: String
    let iconName: String?
    let active: Bool
        
    var body: some View {
        HStack {
            if let icon = iconName {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Text(title)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(12)
        .background(active ? Color("SelectionColor") : Color.clear)
        .cornerRadius(12)
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(title: "All", iconName: "box", active: false)
            .preferredColorScheme(.dark)
    }
}
