//
//  UITextView.swift
//  Writer
//
//  Created by Michal Jach on 22/11/2020.
//

import Foundation
import UIKit

extension UITextView {
    var markedTextNSRange: NSRange? {
        guard let markedTextRange = markedTextRange else { return nil }
        let location = offset(from: beginningOfDocument, to: markedTextRange.start)
        let length = offset(from: markedTextRange.start, to: markedTextRange.end)
        return NSRange(location: location, length: length)
    }
}
