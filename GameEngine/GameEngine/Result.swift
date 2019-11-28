import Foundation

public struct Result<Question: Hashable> {
    public let answers: [Question: Bool]
    public let score: Int
}
