import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var wrongAnswerButton: UIButton!
    @IBOutlet weak var correctAnswerButton: UIButton!
    @IBOutlet weak var translationLabelTopConstraint: NSLayoutConstraint!
    
    private(set) var questions = [String: String]()
    var selectedOptions: [String: Bool] = [:]
    private var selection: (([String: Bool]) -> Void)? = nil
    
    var questionsCount = 0
    
    convenience init(questions: [String: String], selection: @escaping ([String: Bool]) -> Void) {
        self.init()
        self.questions = questions
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Question"
        questionsCount = 0
        if !questions.isEmpty {
            showQuestion()
        }
    }
    
    func showQuestion() {
        questionLabel.text = Array(questions.keys)[questionsCount]
        translationLabel.text = Array(questions.values)[questionsCount]
        animateTranslation()
    }
    
    func animateTranslation() {
        UIView.animate(withDuration: 4.0, delay: 0, options: .curveLinear, animations: { [weak self] in
            
            self?.translationLabel.isHidden = false
            self?.isCorrectAndWrongButtonEnabled(true)
            self?.translationLabelTopConstraint.constant = UIScreen.main.bounds.height - 150
        }) { [weak self] (animationCompleted) in
            self?.translationLabel.isHidden = true
            self?.isCorrectAndWrongButtonEnabled(false)
            self?.incrementQuestionCount()
        }
    }
    
    private func isCorrectAndWrongButtonEnabled(_ enabled: Bool) {
        self.correctAnswerButton.isEnabled = enabled
        self.wrongAnswerButton.isEnabled = enabled
    }
    
    @IBAction func wrongButtonClicked(_ sender: Any) {
        setAnswer(answer: false)
    }
    
    @IBAction func correctButtonClicked(_ sender: Any) {
        setAnswer(answer: false)
    }
    
    private func setAnswer(answer: Bool) {
        guard let question = questionLabel.text, questions.keys.contains(question) else {
            return
        }
        
        selectedOptions[question] = answer
    }
    
    func incrementQuestionCount() {
        if questionsCount < questions.count {
            questionsCount += 1
        } else {
            // show result
        }
    }
}
