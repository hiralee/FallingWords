//
//  Result.swift
//  GameEngine
//
//  Created by hiralee malaviya on 08.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Bool]
    public let score: Int
}
