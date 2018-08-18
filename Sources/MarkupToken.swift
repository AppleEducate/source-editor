//
//  MarkupToken.swift
//  SourceEditor
//
//  Created by Bruno Philipe on 8/17/18.
//

import Foundation
import SavannaKit

public enum MarkupTokenType {
	case section(level: Int)
	case hyperlink
	case bullet
	case strong
	case emphasis
	case quote
	case code
	case symbol
	case editorPlaceholder
	case plain
}

protocol MarkupToken: Token {
	
	var type: MarkupTokenType { get }
	
}

extension MarkupToken {
	
	var isEditorPlaceholder: Bool {
		if case .editorPlaceholder = type
		{
			return true
		}
		
		return false
	}
	
	var isPlain: Bool {
		if case .plain = type
		{
			return true
		}
		
		return false
	}
	
}

struct SimpleMarkupToken: MarkupToken {

	let type: MarkupTokenType
	
	let range: Range<String.Index>
	
}
