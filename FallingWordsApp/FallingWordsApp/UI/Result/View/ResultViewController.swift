import Foundation
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var summary = ""
    private(set) var answers = [PresentableAnswer]()
    
    private static let resultCell = "ResultCell"
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Result"
        summaryLabel.text = summary
        tableView.register(UINib(nibName: ResultViewController.resultCell, bundle: nil), forCellReuseIdentifier: ResultViewController.resultCell)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: UITableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultViewController.resultCell) as? ResultCell
        
        let result = answers[indexPath.row]
        
        cell?.questionLabel.text = result.question
        cell?.correctAnswerLabel.text = result.answer
        
        if result.isCorrectAnswer {
            cell?.correctAnswerLabel.textColor = .green
        } else {
            cell?.correctAnswerLabel.textColor = .red
        }
        
        return cell!
    }
}
