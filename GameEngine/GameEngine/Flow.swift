import Foundation

class Flow<R: Router> {
    typealias Question = R.Question
    typealias Answer = R.Answer
    
    private let router: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
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
    
    private func callback() -> ([Answer]) -> Void {
        return { [unowned self] answers in
            for (question, answer) in zip(self.questions, answers) {
                self.answers[question] = answer
            }
            self.router.routeTo(result: self.result())
        }
    }
    
    private func result() -> Result<Question, Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
}
