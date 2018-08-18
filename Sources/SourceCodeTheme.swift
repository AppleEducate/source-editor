//
//  SourceCodeTheme.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation
import SavannaKit

public protocol SourceCodeTheme: SyntaxColorTheme {
	
	func color(for syntaxColorType: SourceCodeTokenType) -> Color
	
}
