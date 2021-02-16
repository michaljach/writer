//
//  ToolbarView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI

struct ToolbarView: View {
    @State var hasTrialRestriction = false
    
    var body: some View {
        HStack {
            Spacer()
            if hasTrialRestriction {
                NavigationLink(destination: GetFullVersionView().navigationBarTitle("", displayMode: .inline)) {
                    Image("add")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("AccentColor"))
                        .opacity(0.4)
                }
            } else {
                NavigationLink(destination: Editor().navigationBarTitle("", displayMode: .inline)) {
                    Image("add")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("AccentColor"))
                }
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
