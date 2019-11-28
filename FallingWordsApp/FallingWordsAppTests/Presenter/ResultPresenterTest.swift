//
//  ResultPresenterTest.swift
//  FallingWordsAppTests
//
//  Created by hiralee malaviya on 10.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation
import XCTest
import GameEngine
@testable import FallingWordsApp

class ResultPresenterTest: XCTestCase {
    
    func test_title_returnsFormattedTitle() {
        let sut = ResultPresenter(result: .make(), questions: [:], correctAnswers: [:])
        
        XCTAssertEqual(sut.title, "Result")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let sut = ResultPresenter(result: .make(), questions: [:], correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = ["A1": true, "A2": false]
        let questions = ["Q1": "A1", "Q2": "A2"]
        let result = Result<String>.make(answers: answers, score: 1)
        
        let sut = ResultPresenter(result: result, questions: questions, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = ["Q1": false]
        let questions = ["Q1": "A1"]
        let correctAnswers = ["Q1": "A1"]
        let result = Result<String>.make(answers: answers)
        
        let sut = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.first!.isCorrectAnswer, false)
    }
    
    func test_presentableAnswers_withTwoQuestions() {
        let answers = ["Q1": true, "Q2": false]
        let correctAnswers = ["Q1": "A1", "Q2": "A2"]
        let orderedQuestions = ["Q1": "A1", "Q2": "A2"]
        let result = Result<String>.make(answers: answers)
        
        let sut = ResultPresenter(result: result, questions: orderedQuestions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
    }
}
