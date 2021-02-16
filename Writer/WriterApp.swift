//
//  WriterApp.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import SwiftUI
import StoreKit

@main
struct WriterApp: App {
    let persistenceController = PersistenceController.shared
    let settings = UserSettings()
    let storeManager = StoreManager()
    
    let productIDs = [
        "com.mj.Writer.FullVersionOneTime",
    ]
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settings)
                .environmentObject(storeManager)
                .onAppear {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIDs)
                }
        }
    }
}

extension App {
    static var appVersion: String? {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        return "\(version) build \(build)"
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
