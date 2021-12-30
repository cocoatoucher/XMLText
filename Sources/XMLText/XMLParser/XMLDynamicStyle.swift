//
//  XMLDynamicStyle.swift
//  XMLText
//
//  Implementation in this file is taken from
//  SwiftRichString repository on GitHub.
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

class XMLDynamicStyle {
    
    // MARK: - Public Properties
    
    /// Tag read for this style.
    let tag: String
    
    /// Style found in receiver `TextStyleGroup` instance.
    let style: StyleProtocol?
    
    /// Attributes found in the xml tag.
    let xmlAttributes: [String: String]?
    
    // MARK: - Initialization
    
    init(
        tag: String,
        style: StyleProtocol?,
        xmlAttributes: [String: String]?
    ) {
        self.tag = tag
        self.style = style
        self.xmlAttributes = xmlAttributes
    }
    
    func enumerateAttributes(_ handler: ((_ key: String, _ value: String) -> Void)) {
        guard let xmlAttributes = xmlAttributes else {
            return
        }
        
        xmlAttributes.keys.forEach {
            handler($0, xmlAttributes[$0]!)
        }
    }
    
}
