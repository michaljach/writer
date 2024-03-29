//
//  EditorViewProtocols.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import UIKit
import SwiftUI

public struct TextFormattingRule {
    public typealias SymbolicTraits = UIFontDescriptor.SymbolicTraits
    
    let key: NSAttributedString.Key?
    let value: Any?
    let fontTraits: SymbolicTraits
    
    public init(key: NSAttributedString.Key, value: Any) {
        self.init(key: key, value: value, fontTraits: [])
    }
    
    public init(fontTraits: SymbolicTraits) {
        self.init(key: nil, value: nil, fontTraits: fontTraits)
    }
    
    init(key: NSAttributedString.Key? = nil, value: Any? = nil, fontTraits: SymbolicTraits = []) {
        self.key = key
        self.value = value
        self.fontTraits = fontTraits
    }
}

public struct HighlightRule {
    let pattern: NSRegularExpression
    
    let formattingRules: Array<TextFormattingRule>
    
    public init(pattern: NSRegularExpression, formattingRule: TextFormattingRule) {
        self.init(pattern: pattern, formattingRules: [formattingRule])
    }
    
    public init(pattern: NSRegularExpression, formattingRules: Array<TextFormattingRule>) {
        self.pattern = pattern
        self.formattingRules = formattingRules
    }
}

internal protocol EditorViewProtocol {
    var text: String { get set }
    var highlightRules: [HighlightRule] { get }
}

extension EditorViewProtocol {
    
    var placeholderFont: SystemColorAlias {
        get { SystemColorAlias() }
    }
    
    public typealias SystemFontAlias = UIFont
    public typealias SystemColorAlias = UIColor
    
    static func getHighlightedText(text: String, highlightRules: [HighlightRule], font: SystemFontAlias?, color: SystemColorAlias?, settings: UserSettings) -> NSMutableAttributedString {
        let highlightedString = NSMutableAttributedString(string: text)
        let all = NSRange(location: 0, length: text.utf16.count)
        
        let editorFont = settings.fontFace == "default" ? UIFont.systemFont(ofSize: CGFloat(settings.fontSize), weight: .medium) : UIFont.monospacedSystemFont(ofSize: CGFloat(settings.fontSize), weight: .medium)
        let editorTextColor = color ?? UIColor.label
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        highlightedString.addAttribute(.font, value: editorFont, range: all)
        highlightedString.addAttribute(.foregroundColor, value: editorTextColor, range: all)
        highlightedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: all)
        
        highlightRules.forEach { rule in
            let matches = rule.pattern.matches(in: text, options: [], range: all)
            
            matches.forEach { match in
                rule.formattingRules.forEach { formattingRule in

                    var font = UIFont()

                    highlightedString.enumerateAttributes(in: match.range, options: []) { attributes, range, stop in
                        if let fontAttribute = attributes.first(where: { $0.key == .font }) {
                            let previousFont = fontAttribute.value as! UIFont
                            font = previousFont.with(formattingRule.fontTraits)
                            highlightedString.addAttribute(.font, value: font, range: match.range)
                        }
                    }

                    guard let key = formattingRule.key, let value = formattingRule.value else { return }
                    highlightedString.addAttribute(key, value: value, range: match.range)
                }
            }
        }
        
        return highlightedString
    }
}

fileprivate let inlineCodeRegex = try! NSRegularExpression(pattern: "`[^`]*`", options: [])
fileprivate let codeBlockRegex = try! NSRegularExpression(pattern: "(`){3}((?!\\1).)+\\1{3}", options: [.dotMatchesLineSeparators])
fileprivate let headingRegex = try! NSRegularExpression(pattern: "^#{1,6}\\s.*$", options: [.anchorsMatchLines])
fileprivate let linkOrImageRegex = try! NSRegularExpression(pattern: "!?\\[([^\\[\\]]*)\\]\\((.*?)\\)", options: [])
fileprivate let boldRegex = try! NSRegularExpression(pattern: "((\\*|_){2})((?!\\1).)+\\1", options: [])
fileprivate let underscoreEmphasisRegex = try! NSRegularExpression(pattern: "(?<!_)_[^_]+_(?!\\*)", options: [])
fileprivate let asteriskEmphasisRegex = try! NSRegularExpression(pattern: "(?<!\\*)(\\*)((?!\\1).)+\\1(?!\\*)", options: [])
fileprivate let boldEmphasisAsteriskRegex = try! NSRegularExpression(pattern: "(\\*){3}((?!\\1).)+\\1{3}", options: [])
fileprivate let blockquoteRegex = try! NSRegularExpression(pattern: "^>.*", options: [.anchorsMatchLines])
fileprivate let horizontalRuleRegex = try! NSRegularExpression(pattern: "\n\n(-{3}|\\*{3})\n", options: [])
fileprivate let unorderedListRegex = try! NSRegularExpression(pattern: "^(\\-|\\*)\\s", options: [.anchorsMatchLines])
fileprivate let orderedListRegex = try! NSRegularExpression(pattern: "^\\d*\\.\\s", options: [.anchorsMatchLines])
fileprivate let buttonRegex = try! NSRegularExpression(pattern: "<\\s*button[^>]*>(.*?)<\\s*/\\s*button>", options: [])
fileprivate let hashtagRegex = try! NSRegularExpression(pattern: "^*#[a-z]+\\s+", options: [])
fileprivate let strikethroughRegex = try! NSRegularExpression(pattern: "(~)((?!\\1).)+\\1", options: [])

let codeFont = UIFont.monospacedSystemFont(ofSize: UIFont.systemFontSize, weight: .thin)
let headingTraits: UIFontDescriptor.SymbolicTraits = [.traitBold, .traitExpanded]
let boldTraits: UIFontDescriptor.SymbolicTraits = [.traitBold]
let emphasisTraits: UIFontDescriptor.SymbolicTraits = [.traitItalic]
let boldEmphasisTraits: UIFontDescriptor.SymbolicTraits = [.traitBold, .traitItalic]
let secondaryBackground = UIColor.secondarySystemBackground
let lighterColor = UIColor.lightGray
let textColor = UIColor.label


public extension EditorView {
    static func paragraphStyle() -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        return paragraphStyle
    }
    
    static func createFont(fontFace: String, fontSize: Double, weight: UIFont.Weight) -> UIFont {
        switch fontFace {
        case "monospace":
            return UIFont.monospacedSystemFont(ofSize: CGFloat(fontSize), weight: weight)
        default:
            return UIFont.systemFont(ofSize: CGFloat(fontSize), weight: weight)
        }
    }
    
    static func markdown(fontFace:String, fontSize: Double) -> Array<HighlightRule> {
        return [
            HighlightRule(pattern: inlineCodeRegex, formattingRule: TextFormattingRule(key: .font, value: codeFont)),
            HighlightRule(pattern: codeBlockRegex, formattingRule: TextFormattingRule(key: .font, value: codeFont)),
            HighlightRule(pattern: headingRegex, formattingRules: [
                TextFormattingRule(fontTraits: headingTraits),
                TextFormattingRule(key: .font, value: createFont(fontFace: fontFace, fontSize: fontSize + 4, weight: .heavy)),
                TextFormattingRule(key: .paragraphStyle, value: paragraphStyle())
            ]),
            HighlightRule(pattern: hashtagRegex, formattingRules: [
                TextFormattingRule(key: .link, value: "link"),
                TextFormattingRule(key: .font, value: createFont(fontFace: fontFace, fontSize: fontSize, weight: .bold)),
            ]),
            HighlightRule(pattern: linkOrImageRegex, formattingRule: TextFormattingRule(key: .underlineStyle, value: NSUnderlineStyle.single.rawValue)),
            HighlightRule(pattern: boldRegex, formattingRule: TextFormattingRule(key: .font, value: createFont(fontFace: fontFace, fontSize: fontSize, weight: .heavy))),
            HighlightRule(pattern: asteriskEmphasisRegex, formattingRule: TextFormattingRule(fontTraits: emphasisTraits)),
            HighlightRule(pattern: underscoreEmphasisRegex, formattingRule: TextFormattingRule(fontTraits: emphasisTraits)),
            HighlightRule(pattern: boldEmphasisAsteriskRegex, formattingRule: TextFormattingRule(fontTraits: boldEmphasisTraits)),
            HighlightRule(pattern: blockquoteRegex, formattingRule: TextFormattingRule(key: .backgroundColor, value: secondaryBackground)),
            HighlightRule(pattern: horizontalRuleRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: unorderedListRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: orderedListRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: buttonRegex, formattingRules: [
                TextFormattingRule(key: .foregroundColor, value: lighterColor),
                TextFormattingRule(key: .link, value: "link"),
            ]),
            HighlightRule(pattern: strikethroughRegex, formattingRules: [
                TextFormattingRule(key: .strikethroughStyle, value: NSUnderlineStyle.single.rawValue),
                TextFormattingRule(key: .strikethroughColor, value: textColor)
            ])
        ]
    }
}

