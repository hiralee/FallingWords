import Foundation

class Flow<R: Router> {
    typealias Question = R.Question
    typealias Answer = R.Answer
    
    private let router: R
    private let questions: [Question: Answer]
    private var answers: [Question: Bool] = [:]
    private var scoring: ([Question: Bool]) -> Int
    
    init(questions: [Question: Answer], router: R, scoring: @escaping ([Question: Bool]) -> Int) {
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
    
    private func callback() -> ([Question: Bool]) -> Void {
        return { [unowned self] answers in
            self.answers = answers
            self.router.routeTo(result: self.result())
        }
    }
    
    private func result() -> Result<Question, Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
}
