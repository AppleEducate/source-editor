//
//  MarkdownLexer.swift
//  ArgonPro
//
//  Created by Bruno Philipe on 8/17/18.
//  Copyright © 2018 Bruno Philipe. All rights reserved.
//

import Foundation
import SavannaKit

public class MarkdownLexer: MarkupRegexLexer {
	lazy var generators: [TokenGenerator] = {
		var generators = [TokenGenerator?]()
		
		generators.append(contentsOf: (1...6).map({ regexGenerator("^#{\($0)}($|[^#].*$)", tokenType: .section(level: $0)) }))
		generators.append(regexGenerator("^.+?\\n={2,}$", tokenType: .section(level: 1)))
		generators.append(regexGenerator("^.+?\\n-{2,}$", tokenType: .section(level: 2)))
		generators.append(regexGenerator("^([*+-]|(\\d+\\.))\\s+", tokenType: .bullet))
		generators.append(regexGenerator("\\*.+?\\*", tokenType: .emphasis))
		generators.append(regexGenerator("[*_]{2}.+?[*_]{2}", tokenType: .strong))
		generators.append(regexGenerator("_.+?_", tokenType: .emphasis))
		generators.append(regexGenerator("^>\\s+", tokenType: .quote))
		generators.append(regexGenerator("\\[.+?\\][\\(\\[].*?[\\)\\]]", tokenType: .hyperlink))
		generators.append(regexGenerator("^(```)\\w*$\\n(.|\\n)+?^(```)$", tokenType: .code))
		generators.append(regexGenerator("^(~~~)\\w*$\\n(.|\\n)+?^(~~~)$", tokenType: .code))
		generators.append(regexGenerator("`.+?`", tokenType: .code))
		generators.append(regexGenerator("^( {4}|\t).+$", tokenType: .code))
		
		return generators.compactMap( { $0 })
	}()
	
	public init() {
	}
	
	public func generators(source: String) -> [TokenGenerator] {
		return generators
	}
}
