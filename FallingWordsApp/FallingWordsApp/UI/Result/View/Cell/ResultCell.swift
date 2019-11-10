import Foundation
import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sizeToFit()
        layoutIfNeeded()
    }
}
