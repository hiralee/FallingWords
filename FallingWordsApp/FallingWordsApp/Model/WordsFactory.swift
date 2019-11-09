import Foundation

protocol WordsFactoryProtocol {
    func fetchQuestions(count: Int, fetch option: WordFetchingOption) -> (questions: [String: String], correctAnswers: [String: String])
}

enum WordFetchingOption {
    case local
    case remote
}

class WordsFactory: WordsFactoryProtocol {
    let wordFetcher = WordFetcher()
    var words: [Word] = []
    
    func fetchQuestions(count: Int, fetch option: WordFetchingOption) -> (questions: [String: String], correctAnswers: [String: String]) {
        
        var questions: [String: String] = [:]
        var correctAnswers: [String: String] = [:]
        
        fetchWords(option: option, completion: { [weak self] (words) in
            self?.words = words
        })
        
        if !words.isEmpty {
            let wrapper = fetchWords(count: count)
            questions = wrapper.questions
            correctAnswers = wrapper.correctAnswers
        }
        
        return (questions, correctAnswers)
    }
    
    private func fetchWords(option: WordFetchingOption, completion: @escaping ([Word]) -> Void) {
        switch option {
        case .local:
            wordFetcher.fetchWordsLocally { (words) in
                completion(words)
            }
        case .remote:
            wordFetcher.fetchWordsRemotely { (words) in
                completion(words)
            }
        }
    }
    
    private func fetchWords(count: Int) -> (questions: [String: String], correctAnswers: [String: String]) {
        var questionCount = count
        var questions: [String: String] = [:]
        var correctAnswers: [String: String] = [:]
        
        while questionCount > 0 {
            let provideCorrectAnswer = probablityOfCorrectAnswer()
            let word = getRandomWordPair()
            correctAnswers[word.word] = word.translation
            
            if provideCorrectAnswer == 0 {
                questions[word.word] = getRandomTranslation()
            } else {
                questions[word.word] = word.translation
            }
            
            questionCount -= 1
        }
        
        return (questions, correctAnswers)
    }
    
    private func probablityOfCorrectAnswer() -> Int {
        return Int.random(in: 0 ... 1)
    }
    
    private func getRandomWordPair() -> Word {
        return words[Int.random(in: 0 ..< words.count)]
    }
    
    private func getRandomTranslation() -> String {
        return words[Int.random(in: 0 ..< words.count)].translation
    }
}
