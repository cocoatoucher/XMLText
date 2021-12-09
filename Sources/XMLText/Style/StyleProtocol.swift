//
//  StyleProtocol.swift
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

public enum StyleModifier {
    case font(SwiftUI.Font)
    case foregroundColor(Color)
    case strikethroughColor(Color)
    case strikethroughStyle(NSUnderlineStyle)
    case underline(Color)
    case underlineStyle(NSUnderlineStyle)
    case kerning(CGFloat)
    case tracking(CGFloat)
    case baselineOffset(CGFloat)
    case link(URL)
}

public protocol StyleProtocol {
    var modifiers: [StyleModifier] { get }
    
    func add(to source: AttributedString) -> AttributedString
}

public extension StyleProtocol {
    
    func add(to source: AttributedString) -> AttributedString {
        var result = source
        for modifier in self.modifiers {
            switch modifier {
            case .font(let font):
                result.font = font
            case .foregroundColor(let color):
                result.foregroundColor = color
            case .strikethroughColor(let color):
                result.strikethroughColor = .init(color)
            case .strikethroughStyle(let style):
                result.strikethroughStyle = style
            case .underline(let color):
                result.underlineColor = .init(color)
            case .underlineStyle(let style):
                result.underlineStyle = style
            case .kerning(let kerning):
                result.kern = kerning
            case .tracking(let tracking):
                result.tracking = tracking
            case .baselineOffset(let baselineOffset):
                result.baselineOffset = baselineOffset
            case .link(let link):
                result.link = link
            }
        }
        return result
    }
    
}
