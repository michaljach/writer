//
//  HeaderView.swift
//  Writer
//
//  Created by Michal Jach on 06/11/2020.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.gray)
            .padding(.top, 12)
            .padding(.leading, 12)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Preview")
    }
}
