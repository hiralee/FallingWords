import Foundation
import GameEngine

struct ResultPresenter {
    let result: Result
    let questions: [String: String]
    let correctAnswers: [String: String]
    
    var title: String {
        return "Result"
    }
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return questions.map { question in
            guard let userAnswer = result.answers[question.key],
                let correctAnswer = correctAnswers[question.key] else {
                    fatalError("Couldn't find correct answer for question: \(question)")
            }
            
            let isCorrectTranslation: Bool = (question.value == correctAnswer)
            let isCorrectAnswer: Bool = (isCorrectTranslation == userAnswer) ? true : false
            
            return PresentableAnswer(question: question.key, answer: correctAnswer, isCorrectAnswer: isCorrectAnswer)
        }
    }
}
