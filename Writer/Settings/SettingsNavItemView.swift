//
//  SettingsItemView.swift
//  Writer
//
//  Created by Michal Jach on 06/11/2020.
//

import SwiftUI

struct SettingsNavItemView<Content: View, Content1: View>: View {
    var title: String
    var current: Content1
    let destination: Content
    
    init(title: String, current: () -> Content1, @ViewBuilder contentBuilder: () -> Content) {
        self.title = title
        self.current = current()
        self.destination = contentBuilder()
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .fontWeight(.medium)
            Spacer()
            
            current
        }
    }
}

struct SettingsNavItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsNavItemView(title: "Setting", current: { EmptyView() }) {
            
        }
    }
}
