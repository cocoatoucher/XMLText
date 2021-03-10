//
//  XMLTextBuilder.swift
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

class XMLTextBuilder: NSObject {
    
    // MARK: Nested types
    
    struct Error: Swift.Error {
        let parserError: Swift.Error
        let line: Int
        let column: Int
    }
    
    // MARK: Private Properties
    
    private let didFindNewString: (String, [StyleProtocol]) -> Void
    
    private static let topTag = "source"
    
    /// Parser engine.
    private var xmlParser: XMLParser
    
    /// Parsing options.
    private var options: XMLParsingOptions {
        return styleGroup?.xmlParsingOptions ?? []
    }
    
    /// Base style to apply as common style of the entire string.
    private var baseStyle: StyleProtocol? {
        return styleGroup?.baseStyle
    }
    
    /// Styles to apply.
    private var styles: [String: StyleProtocol] {
        return styleGroup?.styles ?? [:]
    }
    
    /// Styles applied at each fragment.
    private var xmlStylers = [XMLDynamicStyle]()

    // The XML parser sometimes splits strings, which can break localization-sensitive
    // string transforms. Work around this by using the currentString variable to
    // accumulate partial strings, and then reading them back out as a single string
    // when the current element ends, or when a new one is started.
    private var currentString: String?
    
    /// StyleGroup instance.
    private weak var styleGroup: StyleGroup?
        
    // MARK: - Initialization

    init?(
        styleGroup: StyleGroup,
        string: String,
        didFindNewString: @escaping (String, [StyleProtocol]) -> Void
    ) {
        self.styleGroup = styleGroup
        
        self.didFindNewString = didFindNewString

        let xmlString = (styleGroup.xmlParsingOptions.contains(.escapeString) ? string.escapeWithUnicodeEntities() : string)
        let xml = (styleGroup.xmlParsingOptions.contains(.doNotWrapXML) ?
                    xmlString :
                    "<\(XMLTextBuilder.topTag)>\(xmlString)</\(XMLTextBuilder.topTag)>")
        
        guard let data = xml.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        self.xmlParser = XMLParser(data: data)
        
        if let baseStyle = styleGroup.baseStyle {
            self.xmlStylers.append(
                XMLDynamicStyle(tag: XMLTextBuilder.topTag, style: baseStyle)
            )
        }
        
        super.init()
        
        xmlParser.shouldProcessNamespaces = false
        xmlParser.shouldReportNamespacePrefixes = false
        xmlParser.shouldResolveExternalEntities = false
        xmlParser.delegate = self
    }
    
    // MARK: Public functions
    
    func parse() throws {
        guard xmlParser.parse() else {
            let line = xmlParser.lineNumber
            let shiftColumn = (line == 1 && options.contains(.doNotWrapXML) == false)
            let shiftSize = XMLTextBuilder.topTag.lengthOfBytes(using: String.Encoding.utf8) + 2
            let column = xmlParser.columnNumber - (shiftColumn ? shiftSize : 0)
            
            throw Error(parserError: xmlParser.parserError!, line: line, column: column)
        }
    }
    
    // MARK: Private functions
    
    private func enter(element elementName: String, attributes: [String: String]) {
        guard elementName != XMLTextBuilder.topTag else {
            return
        }
        
        if elementName != XMLTextBuilder.topTag {
            xmlStylers.append(
                XMLDynamicStyle(
                    tag: elementName,
                    style: styles[elementName]
                )
            )
        }
    }
    
    private func exit(element elementName: String) {
        xmlStylers.removeLast()
    }
    
    private func foundNewString() {
        didFindNewString(currentString ?? "", xmlStylers.compactMap { $0.style })
        currentString = nil
    }
    
}

extension XMLTextBuilder: XMLParserDelegate {
    @objc func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String]
    ) {
        foundNewString()
        enter(element: elementName, attributes: attributeDict)
    }
    
    @objc func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        foundNewString()
        guard elementName != XMLTextBuilder.topTag else {
            return
        }
        
        exit(element: elementName)
    }
    
    @objc func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        currentString = (currentString ?? "").appending(string)
    }
}

private class XMLDynamicStyle {
    
    // MARK: - Public Properties
    
    /// Tag read for this style.
    let tag: String
    
    /// Style found in receiver `TextStyleGroup` instance.
    let style: StyleProtocol?
    
    // MARK: - Initialization
    
    init(
        tag: String,
        style: StyleProtocol?
    ) {
        self.tag = tag
        self.style = style
    }
    
}

private extension String {
    
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

