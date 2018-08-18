//
//  MarkupRegexLexer.swift
//  ArgonModel-framework
//
//  Created by Bruno Philipe on 8/17/18.
//

import Foundation
import SavannaKit

public protocol MarkupRegexLexer: RegexLexer {
	
}

extension MarkupRegexLexer {
	
	func regexGenerator(_ pattern: String,
						options: NSRegularExpression.Options = [.anchorsMatchLines],
						tokenType: MarkupTokenType) -> TokenGenerator? {
		
		return regexGenerator(pattern, options: options, transformer: { (range) -> Token in
			return SimpleMarkupToken(type: tokenType, range: range)
		})
	}
	
	func keywordGenerator(_ words: [String], tokenType: MarkupTokenType) -> TokenGenerator {
		
		return .keywords(KeywordTokenGenerator(keywords: words, tokenTransformer: { (range) -> Token in
			return SimpleMarkupToken(type: tokenType, range: range)
		}))
	}
	
}
