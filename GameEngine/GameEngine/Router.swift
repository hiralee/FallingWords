import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(questions: [Question: Answer], answerCallback: @escaping ([Question: Bool]) -> Void)
    func routeTo(result: Result<Question, Answer>)
}

