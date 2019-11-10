import UIKit
import GameEngine

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(questions: [String: String], answerCallback: @escaping ([String: Bool]) -> Void) {
        show(factory.questionViewController(for: questions, answerCallback: answerCallback))
    }
    
    func routeTo(result: Result) {
        show(factory.resultsViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}


