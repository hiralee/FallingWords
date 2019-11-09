//
//  WordsFactoryTest.swift
//  FallingWordsAppTests
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation
import XCTest
@testable import FallingWordsApp

class WordsFactoryTest: XCTestCase {
    
    func test_sut_exits() {
        XCTAssertNotNil(makeSUT())
    }
    
    func test_sut_fetchOneWord_locally() {
        let sut = makeSUT(questions: ["Q1": "A2"], correctAnswers: ["Q1": "A1"])
        
        let wordFactory = sut.fetchQuestions(count: 1, fetch: .local)
        
        XCTAssertEqual(wordFactory.questions.count, 1)
        XCTAssertEqual(wordFactory.correctAnswers.count, 1)
    }
    
    func makeSUT(questions: [String: String] = [:],
                 correctAnswers: [String: String] = [:]) -> WordsFactorySpy {
        let wordFactory = WordsFactorySpy(questions: questions, correctAnswers: correctAnswers)
        return wordFactory
    }
    
    class WordsFactorySpy: WordsFactoryProtocol {
        let questions: [String: String]
        let correctAnswers: [String: String]
        
        init(questions: [String: String], correctAnswers: [String: String]) {
            self.questions = questions
            self.correctAnswers = correctAnswers
        }
        
        func fetchQuestions(count: Int, fetch option: WordFetchingOption) -> (questions: [String: String], correctAnswers: [String: String]) {
            return (questions, correctAnswers)
        }
    }
}
