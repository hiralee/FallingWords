import XCTest
@testable import FallingWordsApp

class ResultViewControllerTest: XCTestCase {
    
    func test_init_questionViewControllerExists() {
        XCTAssertNotNil(makeSUT())
    }
    
    func test_viewDidLoad_titleIsSet() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.title, "Result")
    }
    
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configuresCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.tableView.cell(at: 0) as? ResultCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configuresCell() {
        let answer = makeAnswer(question: "Q1", givenAnswer: "A2", answer: "A1")
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.tableView.cell(at: 0) as? ResultCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.givenAnswerLabel.text, "A2")
    }
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        sut.view.layoutIfNeeded()
        
        return sut
    }
    
    func makeAnswer(question: String = "", givenAnswer: String = "", answer: String = "", isCorrectAnswer: Bool? = true) -> PresentableAnswer {
        return PresentableAnswer(question: question, givenAnswer: givenAnswer, answer: answer, isCorrectAnswer: isCorrectAnswer!)
    }
}
