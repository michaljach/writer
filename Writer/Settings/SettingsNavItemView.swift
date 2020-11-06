//
//  SettingsItemView.swift
//  Writer
//
//  Created by Michal Jach on 06/11/2020.
//

import SwiftUI

struct SettingsNavItemView<Content: View>: View {
    var title: String
    var current: Text?
    let destination: Content
    
    init(title: String, current: Text?, @ViewBuilder contentBuilder: () -> Content) {
        self.title = title
        self.current = current
        self.destination = contentBuilder()
    }
    
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

struct SettingsNavItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsNavItemView(title: "Setting", current: nil) {
            
        }
    }
}
