//
//  CustomCell.swift
//  ToDoApp
//
//  Created by Igor-Macbook Pro on 12/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func cofigure(todo : ToDoItem) {
        nameLabel.text = todo.name
        detailView.text = todo.detail
        
        let dateF = DateFormatter()
        dateF.dateStyle = .short
        dateF.timeStyle = .medium
        
        dateLabel.text = dateF.string(from: todo.date!)
    }
    
}
