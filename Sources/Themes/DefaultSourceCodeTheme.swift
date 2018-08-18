//
//  DefaultSourceCodeTheme.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation
import SavannaKit

@available(*, deprecated: 1.0, message: "Use `DefaultSourceEditorTheme` instead")
public typealias DefaultSourceCodeTheme = DefaultSourceEditorTheme

open class DefaultSourceEditorTheme: SyntaxColorTheme, MarkupTheme, SourceCodeTheme {
	
	private static let sectionLevelsCount = 6
	private static let lineNumbersColor: Color = Color(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
	
	public init() {
		
	}
	
	open var lineNumbersStyle: LineNumbersStyle? {
		return LineNumbersStyle(font: Font(name: "Menlo", size: 16)!,
								textColor: DefaultSourceEditorTheme.lineNumbersColor)
	}
	
	open var gutterStyle: GutterStyle {
		return GutterStyle(backgroundColor: Color(red: 21/255.0, green: 22/255, blue: 31/255, alpha: 1.0), minimumWidth: 32)
	}
	
	open var font: Font {
		return Font(name: "Menlo", size: 15)!
	}
	
	open var backgroundColor: UIColor {
		return Color(red: 31/255.0, green: 32/255, blue: 41/255, alpha: 1.0)
	}
	
	open func globalAttributes() -> [NSAttributedStringKey: Any] {
		
		var attributes = [NSAttributedStringKey: Any]()
		
		attributes[.font] = font
		attributes[.foregroundColor] = Color.white
		
		return attributes
	}
	
	open func attributes(for token: SavannaKit.Token) -> [NSAttributedStringKey: Any] {
		var attributes = [NSAttributedStringKey: Any]()
		
		if let token = token as? SimpleSourceCodeToken {
			attributes[.foregroundColor] = color(for: token.type)
		}
		
		if let token = token as? MarkupToken {
			for (overrideKey, overrideValue) in overrideAttributes(for: token.type) {
				attributes[overrideKey] = overrideValue
			}
		}
		
		return attributes
	}

	open func color(for syntaxColorType: SourceCodeTokenType) -> Color {
		
		switch syntaxColorType {
		case .plain:
			return .white
			
		case .number:
			return #colorLiteral(red: 0.4549019608, green: 0.4274509804, blue: 0.6901960784, alpha: 1)
			
		case .string:
			return #colorLiteral(red: 0.7212985475, green: 0.1196540506, blue: 0.1572596093, alpha: 1)
			
		case .identifier:
			return #colorLiteral(red: 0.07843137255, green: 0.6117647059, blue: 0.5725490196, alpha: 1)
			
		case .keyword:
			return #colorLiteral(red: 0.7586027038, green: 0.03714548891, blue: 0.5169984272, alpha: 1)
			
		case .comment:
			return #colorLiteral(red: 0.03427617372, green: 0.6120745305, blue: 0, alpha: 1)
			
		case .editorPlaceholder:
			return backgroundColor
		}
	}
	
	open func overrideAttributes(for markupTokenType: MarkupTokenType) -> [NSAttributedStringKey : Any] {
		
		var attributes: [NSAttributedStringKey : Any] = [.foregroundColor: color(for: markupTokenType)]
		
		switch markupTokenType {
		
		case .section(level: let level):
			let sectionFont = font.withSize(scaledBy: pow(1.2, CGFloat(DefaultSourceEditorTheme.sectionLevelsCount + 1 - level)))
			attributes[.font] = sectionFont.boldVariant ?? sectionFont
			
		case .strong:
			attributes[.font] = font.boldVariant ?? font
			
		case .emphasis:
			attributes[.font] = font.italicVariant ?? font
			
		default:
			break
		}
		
		return attributes
	}
	
	open func color(for syntaxColorType: MarkupTokenType) -> Color
	{
		switch syntaxColorType {
			
		case .section:
			return #colorLiteral(red: 0.7586027038, green: 0.03714548891, blue: 0.5169984272, alpha: 1)
			
		case .hyperlink:
			return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
			
		case .bullet:
			return #colorLiteral(red: 0.07843137255, green: 0.6117647059, blue: 0.5725490196, alpha: 1)
			
		case .quote:
			return #colorLiteral(red: 0.7212985475, green: 0.1196540506, blue: 0.1572596093, alpha: 1)
			
		case .code:
			return #colorLiteral(red: 0.4107513034, green: 0.3945278638, blue: 0.5, alpha: 1)
			
		default:
			return .white
		}
	}
}

extension UIFont
{
	private func withFirstAvailableVariantFace(_ variantFaces: [String]) -> UIFont?
	{
		for variant in variantFaces
		{
			let variant = UIFont(descriptor: UIFontDescriptor(fontAttributes: [.family: familyName, .face: variant]),
								 size: pointSize)
			
			// If the variant is not available, we will get a fallback system font.
			if variant.familyName == familyName
			{
				return variant
			}
		}
		
		// No suitable variant found. Return nil
		return nil
	}
	
	/// Returns a bold variant of the receiver font, if available.
	var boldVariant: UIFont?
	{
		return withFirstAvailableVariantFace(["Bold", "Heavy", "Black"])
	}
	
	/// Returns an italic variant of the receiver font, if available.
	var italicVariant: UIFont?
	{
		return withFirstAvailableVariantFace(["Italic", "Oblique"])
	}
	
	/// Returns a variant of the receiver with the point size scaled by `scale`.
	func withSize(scaledBy scale: CGFloat) -> UIFont
	{
		return withSize(pointSize * scale)
	}
}
