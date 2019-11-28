import Foundation
import XCTest
import GameEngine

class GameTest: XCTestCase {
    
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        
        game = startGame(questions: ["Q1": "A2", "Q2": "A2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        router.answerCallback(["Q1": true])
        router.answerCallback(["Q2": false])
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        router.answerCallback(["Q1": true, "Q2": true])
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        router.answerCallback(["Q1": false, "Q2": true])
        
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
}
