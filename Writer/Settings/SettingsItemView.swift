//
//  SettingsItemView.swift
//  Writer
//
//  Created by Michal Jach on 06/11/2020.
//

import SwiftUI

struct SettingsItemView: View {
    var title: String
    var current: Text?
    
    var body: some View {
        NavigationLink(destination: EmptyView()) {
            Text(title)
                .fontWeight(.medium)
            Spacer()
            
            if let current = current {
                current
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray)
            }

            Image("arrow_right")
        }
    }
}

struct SettingsItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItemView(title: "Preview setting", current: Text("Online"))
    }
}
