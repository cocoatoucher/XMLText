//
//  XMLParsingOptions.swift
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

public struct XMLParsingOptions: OptionSet {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// Do not wrap the fragment with a top-level element. Wrapping the XML will
    /// cause a copy of the entire XML string, so for very large strings, it is
    /// recommended that you include a root node yourself and pass this option.
    public static let doNotWrapXML = XMLParsingOptions(rawValue: 1)
    
    /// Perform string escaping to replace all characters which is not supported by NSXMLParser
    /// into the specified encoding with decimal entity.
    /// For example if your string contains '&' character parser will break the style.
    /// This option is active by default.
    public static let escapeString = XMLParsingOptions(rawValue: 2)
    
}
