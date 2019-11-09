import Foundation

public class Game <Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<R>
    
    init(flow: Flow<R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question: Answer], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> {
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, questions: questions, correctAnswers: correctAnswers) })
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question, Answer: Equatable>(_ answers: [Question: Bool],
                                                  questions: [Question: Answer],
                                                  correctAnswers: [Question: Answer]) -> Int {

    return answers.reduce(0) { (score, tuple) in
        let isMatchingAnswer = (correctAnswers[tuple.key] == questions[tuple.key])
        return score + ((isMatchingAnswer == tuple.value) ? 1 : 0)
    }
}

