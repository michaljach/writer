//
//  UIFont.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import Foundation
import UIKit

extension UIFont {
    var bold: UIFont {
        return with(.traitBold)
    }

    var italic: UIFont {
        return with(.traitItalic)
    }

    var boldItalic: UIFont {
        return with([.traitBold, .traitItalic])
    }


    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let traitSet: UIFontDescriptor.SymbolicTraits = UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits);
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traitSet) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let traitSet = self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traitSet) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
