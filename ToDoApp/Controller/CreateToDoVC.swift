//
//  CreateToDoVC.swift
//  ToDoApp
//
//  Created by Igor-Macbook Pro on 12/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreData

class CreateToDoVC : UIViewController {
    
    var currentToDo : ToDoItem?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.text = currentToDo?.detail
        nameLabel.text = currentToDo?.name
    }
}
