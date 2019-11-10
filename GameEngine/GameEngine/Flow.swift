import Foundation

class Flow<R: Router> {
    private let router: R
    private let questions: [String: String]
    private var answers: [String: Bool] = [:]
    private var scoring: ([String: Bool]) -> Int
    
    init(questions: [String: String], router: R, scoring: @escaping ([String: Bool]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        routeToQuestion()
    }
    
    private func routeToQuestion() {
        if !questions.isEmpty {
            router.routeTo(questions: questions, answerCallback: callback())
        }
    }
    
    private func callback() -> ([String: Bool]) -> Void {
        return { [unowned self] answers in
            self.answers = answers
            self.router.routeTo(result: self.result())
        }
    }
    
    private func result() -> Result {
        return Result(answers: answers, score: scoring(answers))
    }
}
