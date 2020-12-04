//
//  State.swift
//  Writer
//
//  Created by Michal Jach on 01/12/2020.
//

import SwiftUI

class GlobalMenu: ObservableObject {
    @Published var selected = "all"
    @Published var folders = []
}
