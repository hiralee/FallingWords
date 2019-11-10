//
//  FlowTest.swift
//  GameEngineTests
//
//  Created by hiralee malaviya on 07.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation
import XCTest
@testable import GameEngine

class FlowTest: XCTestCase {
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: [:]).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1": "A1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1": "A1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2": "A1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2": "A1"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1": "A1", "Q2": "A2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1": "A1", "Q2": "A2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1": "A1", "Q2": "A2"])
        sut.start()
        
        router.answerCallback(["Q11": true])
        router.answerCallback(["Q2": false])
        
        XCTAssertEqual(router.routedQuestions, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1": "A2"])
        sut.start()
        
        router.answerCallback(["Q1": false])
        
        XCTAssertEqual(router.routedQuestions, ["Q1": "A2"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: [:]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_start_withOneQuestions_doesNotRouteToResult() {
        makeSUT(questions: ["Q1": "A1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult() {
        let sut = makeSUT(questions: ["Q1": "A2", "Q2": "A2"])
        sut.start()
        
        router.answerCallback(["Q1": true, "Q2": false])
        
        XCTAssertEqual(router.routedResult!.answers, ["Q1": true, "Q2": false])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut = makeSUT(questions: ["Q1": "A1"], scoring: { _ in 10 })
        sut.start()
        
        router.answerCallback(["Q1": true])
        
        XCTAssertEqual(router.routedResult!.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers() {
        var receivedAnswers = [String: Bool]()
        let sut = makeSUT(questions: ["Q1": "A1"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        
        router.answerCallback(["Q1": true])
        
        XCTAssertEqual(receivedAnswers, ["Q1": true])
    }
    
    
    // MARK: Helpers
    
    private let router = RouterSpy()
    
    private weak var weakSUT: Flow<RouterSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT (Flow<RouterSpy>) instance is not nil.")
    }
    
    private func makeSUT(questions: [String: String],
                         scoring: @escaping ([String: Bool]) -> Int = { _ in 0 }) -> Flow<RouterSpy> {
        let sut = Flow(questions: questions, router: router, scoring: scoring)
        weakSUT = sut
        return sut
    }
}
