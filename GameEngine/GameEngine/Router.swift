import Foundation

public protocol Router {
    func routeTo(questions: [String: String], answerCallback: @escaping ([String: Bool]) -> Void)
    func routeTo(result: Result)
}

