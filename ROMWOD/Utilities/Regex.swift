//
//  Regex.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-08.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

class Regex {

    let internalExp: NSRegularExpression?
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func test (input: String) -> Int {
        guard let matches = self.internalExp?.matches(in: input, options: NSRegularExpression.MatchingOptions.anchored, range: NSMakeRange(0, input.count)) else {
            return 0
        }
        return matches.count
    }
    
    static func ~=(pattern: Regex, input: String) -> Bool {
       return pattern.test(input: input) > 0
    }
}
