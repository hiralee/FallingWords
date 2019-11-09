//
//  WordServiceMapper.swift
//  FallingWordsApp
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation

final class WordItemMapper {
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Word] {
        guard response.statusCode == OK_200,
            let item = try? JSONDecoder().decode([Word].self, from: data)
            else {
                throw WordService.Error.invalidData
        }
        
        return item
    }
}
