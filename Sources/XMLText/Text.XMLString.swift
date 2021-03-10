//
//  Text.XMLString.swift
//  XMLText
//
//  Created by cocoatoucher on 2021-03-08.
//

import SwiftUI

extension Text {
    /// Creates a Text with a given xml string and a style group.
    /// If unable to parse the xml, raw string value will be passed to
    /// resulting Text view.
    ///
    /// - Parameters:
    ///   - xmlString: xmlString to be parsed and styled.
    ///   - styleGroup: Style group used for styling.
    init(xmlString: String, styleGroup: StyleGroup) {
        do {
            var text = Text("")
            let xmlParser = XMLTextBuilder(
                styleGroup: styleGroup,
                string: xmlString,
                didFindNewString: { string, styles in
                    var currentText = Text(string)
                    
                    for style in styles.reversed() {
                        currentText = style.add(to: currentText)
                    }
                    text = text + currentText
                }
            )
            if let xmlParser = xmlParser {
                try xmlParser.parse()
                self = text
            } else {
                self = Text(xmlString)
            }
        } catch {
            debugPrint("Failed to generate attributed string from xml: \(error)")
            self = Text(xmlString)
        }
    }
}

struct Text_XMLString_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            
            // This goes to English Localizable.strings
            let englishXML = "%1$@ <italicStyle>%2$@</italicStyle>"
            // This goes to Swedish Localizable.strings
            let swedishXML = "<italicStyle>%2$@</italicStyle> %1$@"
            VStack {
                Text("Changing order in languages")
                    .padding(.bottom, 10.0)
                
                Text(
                    xmlString: String(format: englishXML, "Director", "Martin"),
                    styleGroup: languageStyleGroup
                )
                Divider()
                Text(
                    xmlString: String(format: swedishXML, "Regissör", "Martin"),
                    styleGroup: languageStyleGroup
                )
            }
            .previewLayout(.sizeThatFits)
            
            let string = "regular <italicStyle>italic&striked</italicStyle> <boldStyle>underlined</boldStyle>"
            Text(
                xmlString: string,
                styleGroup: firstStyleGroup
            )
            .previewLayout(.sizeThatFits)

            let string = "regular <moreKerning>more kerning</moreKerning> <moreTracking>more tracking</moreTracking>"
            Text(
                xmlString: string,
                styleGroup: secondStyleGroup
            )
            .frame(maxWidth: 100.0)
            .previewLayout(.sizeThatFits)

            let string = "regular <moreBaselineOffset>more baseline offset</moreBaselineOffset>"
            Text(
                xmlString: string,
                styleGroup: thirdStyleGroup
            )
            .previewLayout(.sizeThatFits)
        }
    }
    
    static var languageStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .red
        }
        
        let italicStyle = Style { style in
            style.font = .italic(.system(size: 20))()
            style.foregroundColor = .blue
        }
        
        return .init(
            base: normalStyle,
            [
                "italicStyle": italicStyle
            ]
        )
    }
    
    static var firstStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .red
        }
        
        let italicStyle = Style { style in
            style.font = .italic(.system(size: 20))()
            style.foregroundColor = .blue
            style.strikethroughColor = .yellow
        }
        
        let boldStyle = Style { style in
            style.font = .bold(.system(size: 20))()
            style.foregroundColor = .yellow
            style.underlineColor = .red
        }
        
        return .init(
            base: normalStyle,
            [
                "italicStyle": italicStyle,
                "boldStyle": boldStyle
            ]
        )
    }
    
    static var secondStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .red
        }
        
        let moreKerning = Style { style in
            style.font = .italic(.system(size: 20))()
            style.foregroundColor = .blue
            style.kerning = 10.0
        }
        
        let moreTracking = Style { style in
            style.font = .bold(.system(size: 20))()
            style.foregroundColor = .yellow
            style.tracking = 20.0
        }
        
        return .init(
            base: normalStyle,
            [
                "moreKerning": moreKerning,
                "moreTracking": moreTracking
            ]
        )
    }
    
    static var thirdStyleGroup: StyleGroup {
        let normalStyle = Style { style in
            style.font = .subheadline
            style.foregroundColor = .red
        }
        
        let moreBaselineOffset = Style { style in
            style.font = .italic(.system(size: 20))()
            style.foregroundColor = .blue
            style.baselineOffset = 10.0
        }
        
        return .init(
            base: normalStyle,
            [
                "moreBaselineOffset": moreBaselineOffset
            ]
        )
    }
}
