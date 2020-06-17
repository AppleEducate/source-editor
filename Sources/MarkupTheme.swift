//
//  MarkupTheme.swift
//  SourceEditor
//
//  Created by Bruno Philipe on 8/17/18.
//

import Foundation
import SavannaKit

public protocol MarkupTheme: SyntaxColorTheme {
	
	func overrideAttributes(for syntaxColorType: MarkupTokenType) -> [NSAttributedString.Key: Any]

	func color(for markupTokenType: MarkupTokenType) -> Color
	
}
