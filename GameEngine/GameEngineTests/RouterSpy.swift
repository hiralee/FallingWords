import Foundation
import GameEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    
    var answerCallback: ([String]) -> Void = { _ in }
    
    func routeTo(questions: [String], answerCallback: @escaping ([String]) -> Void) {
        routedQuestions = questions
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
