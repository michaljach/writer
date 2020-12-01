//
//  Settings.swift
//  Writer
//
//  Created by Michal Jach on 22/11/2020.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var heading: String {
        didSet {
            UserDefaults.standard.set(heading, forKey: "heading")
        }
    }
    
    init() {
        self.heading = UserDefaults.standard.object(forKey: "heading") as? String ?? ""
    }
}
