//
//  GetFullVersion.swift
//  Writer
//
//  Created by Michal Jach on 12/02/2021.
//

import SwiftUI

struct GetFullVersionView: View {
    @EnvironmentObject var storeManager: StoreManager
    @State private var spinnerVisible = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Section(header: HeaderView(title: "You can store up to 5 notes per folder in trial mode. If you like using Writer purchase full version here via one-time payment. We will never introduce subscriptions.")) {
                        VStack(spacing: 0) {
                            Button(action: {
                                spinnerVisible = true
                                storeManager.purchaseProduct(product: storeManager.myProducts[0], callback: {
                                    spinnerVisible = false
                                })
                            }, label: {
                                Text("Get full version")
                                    .fontWeight(.medium)
                                Spacer()
                                Spacer()
                                ProgressView()
                                    .opacity(spinnerVisible ? 1 : 0)
                                Spacer()
                                Text("One-time payment")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.gray)
                            })
                            .padding()
                        }
                        .background(Color("SelectionColor"))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .navigationBarTitle("Purchase", displayMode: .inline)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color("DividerColor")), alignment: .top)
            }
        }
    }
}
