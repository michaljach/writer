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
        HStack {
            Text(title)
                .fontWeight(.medium)
            Spacer()
            
            if let current = current {
                current
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct SettingsItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItemView(title: "Setting")
    }
}
