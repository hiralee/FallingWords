import UIKit
import GameEngine

protocol ViewControllerFactoryProtocol {
    func questionViewController(for questions: [String: String], answerCallback: @escaping ([String: Bool]) -> Void) -> UIViewController
    func resultsViewController(for result: Result) -> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    private let questions: [String: String]
    private let correctAnswers: [String: String]
    
    init(questions: [String: String], correctAnswers: [String: String]) {
        self.questions = questions
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for questions: [String : String], answerCallback: @escaping ([String : Bool]) -> Void) -> UIViewController {
        let controller = QuestionViewController(questions: questions, selection: answerCallback)
        return controller
    }
    
    func resultsViewController(for result: Result) -> UIViewController {
        let presenter = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let controller = ResultViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
        return controller
    }
}
