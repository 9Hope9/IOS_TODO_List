//
//  ToDoListTableViewCell.swift
//  lab6
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    @IBOutlet weak var itemTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
