//
//  MakeTodoVC.swift
//  ToDoApp
//
//  Created by Igor-Macbook Pro on 12/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreData

class MakeTodoVC : UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var detailTV: UITextView!
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if validate(textView: detailTV) {
            saveTodo()
        }
    }
    
    private func saveTodo() {
        let todo = ToDoItem(context: context)
        
        todo.detail = detailTV.text
        todo.name = nameTF.text
        todo.date = Date.init()
        
        do {
            try context.save()
        }
        catch {
            print("Problems with saving occured \(error)")
        }

    }
    
    private func validate(textView: UITextView) -> Bool {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                
                return false
        }
        
        return true
    }
}
