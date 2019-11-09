import Foundation
import XCTest
@testable import FallingWordsApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_titleIsSet() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.title, "Question")
    }
    
    func test_init_viewController_initializedCorrectly() {
        let sut = makeSUT(questions: ["Q1": "A1"])
        
        XCTAssertEqual(sut.questions, ["Q1": "A1"])
    }
    
    func test_init_questionLabelSet() {
        let sut = makeSUT(questions: ["Q1": "A1"])
        
        XCTAssertEqual(sut.questionLabel.text, "Q1")
    }
    
    func test_init_withCorrectAndWrongButtons() {
        let sut = makeSUT(questions: ["Q1": "A1"])
        
        XCTAssertEqual(sut.correctAnswerButton.titleLabel?.text, "Correct")
        XCTAssertEqual(sut.wrongAnswerButton.titleLabel?.text, "Wrong")
    }
    
    func test_init_withTranslationLabelSet() {
        let sut = makeSUT(questions: ["Q1": "A1"])
        
        XCTAssertEqual(sut.translationLabel.text, "A1")
    }
    
    func test_viewDidLoad_translationLabelAnimated_fromTopToBottom() {
        let sut = makeSUT(questions: ["Q1": "A1"])
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.translationLabel.isHidden)
            XCTAssertFalse(sut.correctAnswerButton.isEnabled)
            XCTAssertFalse(sut.wrongAnswerButton.isEnabled)
        
            XCTAssertEqual(sut.translationLabelTopConstraint.constant, UIScreen.main.bounds.height - 150)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_incrementQuestionCount_onlyIfQuestionsLeft() {
        let sut = makeSUT(questions: ["Q1": "A1"])
        
        sut.incrementQuestionCount()
        sut.incrementQuestionCount()
        
        XCTAssertEqual(sut.questionsCount, 1)
    }
    
    func makeSUT(questions: [String: String] = [:],
                 selection: @escaping ([String: Bool]) -> Void = { _ in }
        ) -> QuestionViewController {
        let view = QuestionViewController(questions: questions,
                                          selection: selection)
        view.loadViewIfNeeded()
        
        return view
    }
}
