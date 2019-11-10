import Foundation
@testable import GameEngine

extension Result {
    static func make(answers: [String: Bool] = [:], score: Int = 0) -> Result {
        return Result(answers: answers, score: score)
    }
}

extension Result: Equatable {
    public static func ==(lhs: Result, rhs: Result) -> Bool {
        return lhs.score == rhs.score && lhs.answers == rhs.answers
    }
}

extension Result: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(answers)
        hasher.combine(score)
    }
}

