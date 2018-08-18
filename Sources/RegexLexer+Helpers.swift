//
//  RegexLexer+Helpers.swift
//  SourceEditor
//
//  Created by Bruno Philipe on 8/17/18.
//

import Foundation
import SavannaKit

extension RegexLexer {
	
	func regexGenerator(_ pattern: String, options: NSRegularExpression.Options = [], transformer: @escaping TokenTransformer) -> TokenGenerator? {
		
		guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
			return nil
		}
		
		return .regex(RegexTokenGenerator(regularExpression: regex, tokenTransformer: transformer))
	}
	
}
