import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer: Equatable
    
    func routeTo(questions: [Question: Answer], answerCallback: @escaping ([Question: Bool]) -> Void)
    func routeTo(result: Result<Question>)
}

