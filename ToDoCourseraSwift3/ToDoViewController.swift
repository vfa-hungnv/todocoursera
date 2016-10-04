//
//  ToDoViewController.swift
//  ToDoCourseraSwift3
//
//  Created by Hung Nguyen on 10/3/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
    @IBOutlet var imageField: UITextField!
    
    @IBOutlet var titleLabel: UITextField!
    
    @IBOutlet var descriptionLabel: UITextView!
    
    var todoItem: ToDo?
    var context: NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let todoItem = todoItem {
            titleLabel.text = todoItem.title
            descriptionLabel.text = todoItem.desciption
            imageField.text = todoItem.image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        if let context = context {
            
            
            if todoItem == nil {
                todoItem = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context) as? ToDo
            }

            todoItem?.title = titleLabel.text
            todoItem?.desciption = descriptionLabel.text
            todoItem?.image = imageField.text
            do {
                try context.save()
                let _ = navigationController?.popViewController(animated: true)
            } catch {
                print(error)
                return
            }
            
            
        }
    }
}
