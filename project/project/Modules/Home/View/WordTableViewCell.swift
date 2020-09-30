//
//  WordTableViewCell.swift
//  project
//
//  Created by Mohammad Bitar on 9/29/20.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var WordLabel: UILabel!
    
    // MARK: - VARAIBLES
    
    var word: String? {
        didSet {
            if word != nil {
                WordLabel.text = word
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
