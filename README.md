<p align="center">
<img src="Docs/logo.png" width="300" max-width="80%" alt="glide"/>
</p>

XMLText is a mini library that can generate SwiftUI `Text` from a given XML string with tags. It uses `AttributedString` to compose the final text output.

```
Text(
    xmlString: "my <bold>localized</bold> and <italic>styled</italic> string",
    styleGroup: myStyleDefinitions
)
```

***The original idea comes directly from [`SwiftRichString` library by `Daniele Margutti` on GitHub](https://github.com/malcommac/SwiftRichString). Code for XML parsing, StyleProtocol, and StyleGroup are taken from this library, slight modifications are made to them in order to generate `SwiftUI` `Text` instead of `NSAttributedString`.***

This is really useful for localising your apps for styled strings without having to know the location of the strings in the code that needs to be styled. This is a pretty fine alternative to having to use `NSAttributedString` with `UIViewRepresentable` of a `UILabel` in a `SwiftUI` app, as the layout of `UIViewRepresentable` for such dynamic views as `UILabel` doesn't always work and is prone to glitches when combined with other `SwiftUI` views.

## Examples
<p align="center">
<img src="Docs/examples.png" width="400" max-width="80%" alt="glide devices"/>
</p>

<p align="center">
iOS 15.0 / macOS 12.0 / tvOS 15.0 / watchOS 8.0
</p>

## Supported `Text` modifiers

#### font(*SwiftUI.Font*)
#### foregroundColor(*Color*)
#### strikethrough(*Color*)
#### underline(*Color*)
#### kerning(*CGFloat*)
#### tracking(*CGFloat*)
#### baselineOffset(*CGFloat*)

## Sample usage

This is an example of XML strings that would appear in your Localizable.strings files with words in different order for each different language, namely English and Swedish for this example.
If you are not familiar with that approach, please note that the style information(`StyleGroup` keys, e.g. `<italicStyle>`) is also contained in the localized strings.


```
// This goes to English Localizable.strings
let englishXML = "%1$@ <italicStyle>%2$@</italicStyle>"

// This goes to Swedish Localizable.strings
let swedishXML = "<italicStyle>%2$@</italicStyle> %1$@"

let normalStyle = Style { style in
	style.font = .subheadline
	style.foregroundColor = .red
}

let italicStyle = Style { style in
	style.font = Font.italic(.system(size: 20))()
	style.foregroundColor = .blue
}

let styleGroup = StyleGroup(
	base: normalStyle,
	["italicStyle": italicStyle]
)

Text(
	xmlString: String(format: englishXML, "Director", "Martin"),
	styleGroup: styleGroup
)
Text(
	xmlString: String(format: swedishXML, "Regissör", "Martin"),
	styleGroup: styleGroup
)
```

### 🔗 Links

You can add links inside your strings via:
`<a href="http://www.example.com">This is a link</a>`

### 🎆 Images (not supported)

It is currently not supported to include `Image` elements within `AttributedString`.

### Custom XML Attributes (not supported)

For example: `<italicStyle myAttribute="something"></italicStyle>`

This is currently not supported for sake of simplicity and given the fact that the library doesn't have so many capabilities for that to make sense. If there would be some use cases regarding this, a similar approach to `XMLDynamicAttributesResolver` of `SwiftRichString` library could be considered in the future.
