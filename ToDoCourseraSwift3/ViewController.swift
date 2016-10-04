//
//  ViewController.swift
//  ToDoCourseraSwift3
//
//  Created by Hung Nguyen on 10/3/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    var todoItems: [ToDo]?
    var context: NSManagedObjectContext?
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let containner = appDelegate.persistentContainer
            context = containner.viewContext
        }
        
        table.dataSource = self
        table.delegate = self

    }
   
    override func viewWillAppear(_ animated: Bool) {
        getToDoList()
        table.reloadData()
    }
    
    private func getToDoList() {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        
        if let context = context {
            do {
                todoItems = try context.fetch(request)
            } catch {
                print(error)
                return
            }
        }
        
    }
    
    fileprivate func deleteToDoItem(atIndex index: IndexPath) {
        let row = index.row
        
        
        if let todoItem = todoItems?[row] {
            if let context = context {
                context.delete(todoItem)
                do {
                    try context.save()
                } catch {

                    let nserror = error as NSError
                    fatalError("Can not delete \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todoItem" {
            if let todoViewControlelr = segue.destination as? ToDoViewController {
                todoViewControlelr.context = context
            }
        }
    }

    @IBAction func addTapped(_ sender: AnyObject) {
        if let todoViewController = storyboard?.instantiateViewController(withIdentifier: "todoViewControlelr") as? ToDoViewController {
            todoViewController.context = context
            navigationController?.pushViewController(todoViewController, animated: true)
        }
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todoItems = todoItems {
            let todoItem = todoItems[indexPath.row]
            if let todoViewController = storyboard?.instantiateViewController(withIdentifier: "todoViewControlelr") as? ToDoViewController {
                todoViewController.context = context
                todoViewController.todoItem = todoItem
                navigationController?.pushViewController(todoViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(100)
        return height
    }
    
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteToDoItem(atIndex: indexPath)
            
            self.viewWillAppear(true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todoItems = todoItems {
            return todoItems.count
        } else {
            return 1
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        if let todoCell = cell as? ToDoCell, let todoItems = todoItems {
            todoCell.title.text = todoItems[indexPath.row].title
            todoCell.todoDescription.text = todoItems[indexPath.row].desciption
            if let imagestr = todoItems[indexPath.row].image {
                if let image = UIImage(named: imagestr) {
                    todoCell.todoImage.image = image
                }
            }
            return todoCell
        }
        return cell
    }
}





