import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var wrongAnswerButton: UIButton!
    @IBOutlet weak var correctAnswerButton: UIButton!
    @IBOutlet weak var translationLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private(set) var questions = [String: String]()
    var selectedOptions: [String: Bool] = [:]
    private var selection: (([String: Bool]) -> Void)? = nil
    
    var questionsCount = 0
    
    var animator: UIViewPropertyAnimator!
    
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
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.questionLabel.text = Array(strongSelf.questions.keys)[strongSelf.questionsCount]
            strongSelf.translationLabel.text = Array(strongSelf.questions.values)[strongSelf.questionsCount]
            strongSelf.animateTranslation()
        }
    }
    
    func animateTranslation() {
        self.translationLabel.isHidden = false
        self.isCorrectAndWrongButtonEnabled(true)
        
        animator = UIViewPropertyAnimator(duration: 5.0, curve: .linear) {
            self.translationLabelTopConstraint.constant = UIScreen.main.bounds.height - self.bottomConstraint.constant*3
            self.view.layoutIfNeeded()
        }
        
        animator.startAnimation()
        animator.addCompletion { (position) in
            self.handleAnimationCompletion()
        }
    }
    
    private func isCorrectAndWrongButtonEnabled(_ enabled: Bool) {
        self.correctAnswerButton.isEnabled = enabled
        self.wrongAnswerButton.isEnabled = enabled
    }
    
    @IBAction func wrongButtonClicked(_ sender: Any) {
        setAnswer(answer: false)
        handleAnimationCompletion()
    }
    
    @IBAction func correctButtonClicked(_ sender: Any) {
        setAnswer(answer: true)
        handleAnimationCompletion()
    }
    
    private func setAnswer(answer: Bool) {
        guard let question = questionLabel.text, questions.keys.contains(question) else {
            return
        }
        
        selectedOptions[question] = answer
    }
    
    private func handleAnimationCompletion() {
        DispatchQueue.main.async { [weak self] in
            self?.animator.stopAnimation(true)
            self?.translationLabel.isHidden = true
            self?.isCorrectAndWrongButtonEnabled(false)
            self?.translationLabelTopConstraint.constant = 40
            self?.view.layoutIfNeeded()
            self?.incrementQuestionCount()
        }
    }
    
    func incrementQuestionCount() {
        if questionsCount < questions.count - 1 {
            questionsCount += 1
            showQuestion()
        } else {
            selection?(selectedOptions)
        }
    }
}
