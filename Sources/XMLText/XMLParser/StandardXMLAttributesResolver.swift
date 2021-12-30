//
//  StandardXMLAttributesResolver.swift
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
import SwiftUI

class StandardXMLAttributesResolver {
    
    func applyDynamicAttributes(
        to attributedString: inout AttributedString,
        xmlStyle: XMLDynamicStyle
    ) {
        let finalStyleToApply = Style()
        xmlStyle.enumerateAttributes { key, value  in
            switch key {
                case "color":
                    finalStyleToApply.foregroundColor = Color(hex: value)
                default: break
            }
        }
        self.styleForUnknownXMLTag(
            xmlStyle.tag,
            to: &attributedString,
            attributes: xmlStyle.xmlAttributes
        )
        attributedString = finalStyleToApply.add(to: attributedString)
    }
    
    func styleForUnknownXMLTag(
        _ tag: String,
        to attributedString: inout AttributedString,
        attributes: [String: String]?
    ) {
        let finalStyleToApply = Style()
        switch tag {
        case "a": // href support
            if let href = attributes?["href"] {
                finalStyleToApply.link = URL(string: href)
            }
        default:
            break
        }
        attributedString = finalStyleToApply.add(to: attributedString)
    }
    
}
