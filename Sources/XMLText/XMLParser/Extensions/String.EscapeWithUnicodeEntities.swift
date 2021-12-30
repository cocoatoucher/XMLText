//
//  String.EscapeWithUnicodeEntities.swift
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

extension String {
    
    static let escapeAmpRegExp = try! NSRegularExpression(pattern: "&(?!(#[0-9]{2,4}|[A-z]{2,6});)", options: NSRegularExpression.Options(rawValue: 0))
    
    func escapeWithUnicodeEntities() -> String {
        let range = NSRange(location: 0, length: self.count)
        return String.escapeAmpRegExp.stringByReplacingMatches(
            in: self,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: range,
            withTemplate: "&amp;"
        )
    }
}
