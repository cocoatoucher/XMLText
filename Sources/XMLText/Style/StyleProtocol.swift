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
    case strikethrough(Color)
    case underline(Color)
    case kerning(CGFloat)
    case tracking(CGFloat)
    case baselineOffset(CGFloat)
}

public protocol StyleProtocol {
    var modifiers: [StyleModifier] { get }
    
    func add(to source: Text) -> Text
}

public extension StyleProtocol {
    
    func add(to source: Text) -> Text {
        var result = source
        for modifier in self.modifiers {
            switch modifier {
            case .font(let font):
                result = result
                    .font(font)
            case .foregroundColor(let color):
                result = result
                    .foregroundColor(color)
            case .strikethrough(let color):
                result = result
                    .strikethrough(true, color: color)
            case .underline(let color):
                result = result
                    .underline(true, color: color)
            case .kerning(let kerning):
                result = result
                    .kerning(kerning)
            case .tracking(let tracking):
                result = result
                    .tracking(tracking)
            case .baselineOffset(let baselineOffset):
                result = result
                    .baselineOffset(baselineOffset)
            }
        }
        return result
    }
    
}
