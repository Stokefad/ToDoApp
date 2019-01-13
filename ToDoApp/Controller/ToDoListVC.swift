//
//  ToDoListVC.swift
//  ToDoApp
//
//  Created by Igor-Macbook Pro on 12/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreData

class ToDoListVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var todoList: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var todoArray : [ToDoItem] = [ToDoItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoList.delegate = self
        todoList.dataSource = self
        
        retrieveTodos()
        todoList.reloadData()
        
        addButton.layer.cornerRadius = 10
        
        deleteButton.isHidden = true
        
        todoList.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        retrieveTodos()
        todoList.reloadData()
    }
    
    
    // DELEGATE METHODS FOR TABLEVIEW
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoList.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction(sender:)))
        rightSwipe.direction = .right
        cell.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction(sender:)))
        leftSwipe.direction = .left
        cell.addGestureRecognizer(leftSwipe)
        
        cell.cofigure(todo: todoArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destVC = storyboard.instantiateViewController(withIdentifier: "CreateToDo") as! CreateToDoVC
        
        destVC.currentToDo = todoArray[indexPath.row]
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    // RIGHT and LEFT SWIPE METHOD
    
    @objc private func rightSwipeAction(sender : UISwipeGestureRecognizer) {
        let location = sender.location(in: todoList)
        
        if let index = todoList.indexPathForRow(at: location) {
            let cell = todoList.cellForRow(at: index) as! CustomCell
            cell.backgroundColor = UIColor.red
            
            todoArray[index.row].onDelete = true
            
            deleteButton.isHidden = false
        }
    }
    
    @objc private func leftSwipeAction(sender : UISwipeGestureRecognizer) {
        let location = sender.location(in: todoList)
        
        if let index = todoList.indexPathForRow(at: location) {
            let cell = todoList.cellForRow(at: index) as! CustomCell
            cell.backgroundColor = UIColor.white
            
            todoArray[index.row].onDelete = false
            
            deleteButton.isHidden = true
        }
    }
    
    // CREATE TODO
    
    @IBAction func addTodo(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destVC = storyboard.instantiateViewController(withIdentifier: "MakeToDo") as! MakeTodoVC
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    // RETRIEVE LIST OF TODOS
    
    private func retrieveTodos() {
        let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        
        do {
            todoArray = try context.fetch(request)
            self.todoList.reloadData()
        }
        catch {
            print("Problem with retrieving occured \(error)")
        }
    }
    
    // DELETE TODO
    
    private func deleteTodo(todo : ToDoItem, index : Int) {
        todoArray.remove(at: index)
        context.delete(todo)
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        todoList.reloadData()
    }
    
    @IBAction func deleteToDo(_ sender: UIButton) {
        var onDeleteArr : [Int] = [Int]()
        
        for i in 0 ... todoArray.count - 1 {
            let cell = todoList.cellForRow(at: IndexPath(row: i, section: 0))
            cell?.backgroundColor = UIColor.white
            
            if todoArray[i].onDelete == true {
                onDeleteArr.append(i)
            }
        }
        
        for item in onDeleteArr {
            deleteTodo(todo: todoArray[item], index: item)
        }
    }
}

