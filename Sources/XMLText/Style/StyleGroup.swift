//
//  StyleGroup.swift
//  XMLText
//
//  Created by cocoatoucher on 2021-03-08.
//
//  Remarkable parts of the implementation in this file
//  is taken from SwiftRichString repository on GitHub.
//  Slight modifications are made.
//  https://github.com/malcommac/SwiftRichString/
//
//  SwiftRichString
//  Elegant Strings & Attributed Strings Toolkit for Swift
//
//  Created by Daniele Margutti.
//  Copyright © 2018 Daniele Margutti. All rights reserved.
//
//    Web: http://www.danielemargutti.com
//    Email: hello@danielemargutti.com
//    Twitter: @danielemargutti

import Foundation

public class StyleGroup: StyleProtocol {
    
    public var modifiers: [StyleModifier] = []
    
    public private(set) var styles: [String: StyleProtocol]
    
    public var baseStyle: StyleProtocol?
    
    public var xmlParsingOptions: XMLParsingOptions = [.escapeString]
    
    public init(
        base: StyleProtocol? = nil,
        _ styles: [String: StyleProtocol] = [:]
    ) {
        self.styles = styles
        self.baseStyle = base
    }
}
