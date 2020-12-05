//
//  EditorView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import UIKit
import SwiftUI

public struct EditorView: UIViewRepresentable, EditorViewProtocol {
    @EnvironmentObject var settings: UserSettings
    
    @Binding var text: String {
        didSet {
            self.onTextChange(text)
        }
    }
    let highlightRules: [HighlightRule]
    
    var onEditingChanged: (UITextView) -> Void = { _ in }
    var onCommit: () -> Void = {}
    var onTextChange: (String) -> Void = { _ in }
    
    private(set) var color: UIColor? = nil
    private(set) var font: UIFont? = nil
    private(set) var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private(set) var onInit: ((UITextView) -> Void)? = nil
    
    public init(
        text: Binding<String>,
        highlightRules: [HighlightRule],
        onEditingChanged: @escaping (UITextView) -> Void = { _ in },
        onCommit: @escaping () -> Void = {},
        onTextChange: @escaping (String) -> Void = { _ in }
    ) {
        _text = text
        self.highlightRules = highlightRules
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.onTextChange = onTextChange
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.textContainerInset = inset
        textView.isScrollEnabled = true
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(Color("LinkColor")),
        ]
        textView.linkTextAttributes = linkAttributes
        textView.backgroundColor = UIColor(Color("BackgroundColor"))
        
        if let onInit = onInit {
            onInit(textView)
        }
        
        return textView
    }
    
    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.isScrollEnabled = false
        
        let highlightedText = EditorView.getHighlightedText(
            text: text,
            highlightRules: highlightRules,
            font: font,
            color: color,
            settings: settings
        )
        
        if let range = uiView.markedTextNSRange {
            uiView.setAttributedMarkedText(highlightedText, selectedRange: range)
        } else {
            uiView.attributedText = highlightedText
        }
        
        uiView.isScrollEnabled = true
        uiView.selectedTextRange = context.coordinator.selectedTextRange
        uiView.backgroundColor = UIColor(Color("BackgroundColor"))
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: EditorView
        var selectedTextRange: UITextRange? = nil
        
        init(_ markdownEditorView: EditorView) {
            self.parent = markdownEditorView
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            textView.autocapitalizationType = .sentences
            textView.reloadInputViews()
            self.parent.text = textView.text
            selectedTextRange = textView.selectedTextRange
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            parent.onEditingChanged(textView)
            textView.selectedTextRange = textView.textRange(from: textView.endOfDocument, to: textView.endOfDocument)
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            parent.onCommit()
        }
        
        public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            print("cliked")
            return false
        }
    }
}

extension EditorView {
    public func defaultColor(_ color: UIColor) -> Self {
        var new = self
        new.color = color
        return new
    }
    
    public func defaultFont(_ font: UIFont) -> Self {
        var new = self
        new.font = font
        return new
    }
    
    public func defaultInset(_ inset: UIEdgeInsets) -> Self {
        var new = self
        new.inset = inset
        return new
    }
    
    public func onInit(_ onInit: @escaping (UITextView) -> Void) -> Self {
        var new = self
        new.onInit = onInit
        return new
    }
}
