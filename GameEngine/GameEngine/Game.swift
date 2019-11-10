import Foundation

public class Game <R: Router> {
    let flow: Flow<R>
    
    init(flow: Flow<R>) {
        self.flow = flow
    }
}

public func startGame<R: Router>(questions: [String: String], router: R, correctAnswers: [String: String]) -> Game<R> {
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, questions: questions, correctAnswers: correctAnswers) })
    flow.start()
    return Game(flow: flow)
}

private func scoring(_ answers: [String: Bool],
                     questions: [String: String],
                     correctAnswers: [String: String]) -> Int {

    return answers.reduce(0) { (score, tuple) in
        let isMatchingAnswer = (correctAnswers[tuple.key] == questions[tuple.key])
        return score + ((isMatchingAnswer == tuple.value) ? 1 : 0)
    }
}

