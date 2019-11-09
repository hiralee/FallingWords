import Foundation
import GameEngine

class RouterSpy: Router {
    
    var routedQuestions: [String : String] = [:]
    var routedResult: Result<String, String>? = nil
    
    var answerCallback: ([String: Bool]) -> Void = { _ in }
    
    func routeTo(questions: [String : String], answerCallback: @escaping ([String : Bool]) -> Void) {
        routedQuestions = questions
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
