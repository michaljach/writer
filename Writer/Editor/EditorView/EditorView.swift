//
//  EditorView.swift
//  Writer
//
//  Created by Michal Jach on 03/11/2020.
//

import UIKit
import SwiftUI

public struct EditorView: UIViewRepresentable, EditorViewProtocol {
    
    @Binding var text: String {
        didSet {
            self.onTextChange(text)
        }
    }
    let highlightRules: [HighlightRule]
    
    var onEditingChanged: () -> Void = {}
    var onCommit: () -> Void = {}
    var onTextChange: (String) -> Void = { _ in }
    
    private(set) var color: UIColor? = nil
    private(set) var font: UIFont? = nil
    private(set) var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    public init(
        text: Binding<String>,
        highlightRules: [HighlightRule],
        onEditingChanged: @escaping () -> Void = {},
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
        let highlightedText = EditorView.getHighlightedText(
            text: text,
            highlightRules: highlightRules,
            font: font,
            color: color
        )
        
        let textView = UITextView()
        
        textView.backgroundColor = UIColor(Color("BackgroundColor"))
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.textContainerInset = inset
        textView.attributedText = highlightedText
        textView.becomeFirstResponder()
        textView.selectedTextRange = textView.textRange(from: textView.endOfDocument, to: textView.endOfDocument)
        
        return textView
    }
    
    public func updateUIView(_ uiView: UITextView, context: Context) {
//                uiView.isScrollEnabled = false
//
//                let highlightedText = EditorView.getHighlightedText(
//                    text: text,
//                    highlightRules: highlightRules,
//                    font: font,
//                    color: color
//                )
//
//                uiView.backgroundColor = UIColor(Color("BackgroundColor"))
//                uiView.selectedTextRange = context.coordinator.selectedTextRange
//                uiView.attributedText = highlightedText
//                uiView.isScrollEnabled = true
//                uiView.selectedTextRange = context.coordinator.selectedTextRange
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: EditorView
        var selectedTextRange: UITextRange? = nil
        
        init(_ markdownEditorView: EditorView) {
            self.parent = markdownEditorView
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            selectedTextRange = textView.selectedTextRange
            let highlightedText = EditorView.getHighlightedText(
                text: textView.text,
                highlightRules: parent.highlightRules,
                font: parent.font,
                color: parent.color
            )
            textView.attributedText = highlightedText
            textView.selectedTextRange = selectedTextRange
            parent.onTextChange(textView.text)
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            let highlightedText = EditorView.getHighlightedText(
                text: parent.text,
                highlightRules: parent.highlightRules,
                font: parent.font,
                color: parent.color
            )
            parent.onEditingChanged()
            selectedTextRange = textView.textRange(from: textView.endOfDocument, to: textView.endOfDocument)
            textView.backgroundColor = UIColor(Color("BackgroundColor"))
            textView.attributedText = highlightedText
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            parent.onCommit()
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
}
