//
//  Style.swift
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
import SwiftUI

public class Style: StyleProtocol {
    
    public var font: SwiftUI.Font?
    
    public var foregroundColor: Color?
    
    public var strikethroughColor: Color?
    
    public var strikethroughStyle: NSUnderlineStyle?
    
    public var underlineColor: Color?
    
    public var underlineStyle: NSUnderlineStyle?
    
    public var kerning: CGFloat?
    
    public var tracking: CGFloat?
    
    public var baselineOffset: CGFloat?
    
    public var link: URL?
    
    public init(_ handler: ((Style) -> Void)? = nil) {
        handler?(self)
    }
    
    public var modifiers: [StyleModifier] {
        var result: [StyleModifier] = []
        if let font = font {
            result.append(.font(font))
        }
        if let foregroundColor = foregroundColor {
            result.append(.foregroundColor(foregroundColor))
        }
        if let strikethroughColor = strikethroughColor {
            result.append(.strikethroughColor(strikethroughColor))
        }
        if let strikethroughStyle = strikethroughStyle {
            result.append(.strikethroughStyle(strikethroughStyle))
        }
        if let underlineColor = underlineColor {
            result.append(.underline(underlineColor))
        }
        if let underlineStyle = underlineStyle {
            result.append(.underlineStyle(underlineStyle))
        }
        if let kerning = kerning {
            result.append(.kerning(kerning))
        }
        if let tracking = tracking {
            result.append(.tracking(tracking))
        }
        if let baselineOffset = baselineOffset {
            result.append(.baselineOffset(baselineOffset))
        }
        if let link = link {
            result.append(.link(link))
        }
        return result
    }
}
