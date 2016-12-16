//
//  ChoresTableViewController.swift
//  jillderon-pset6
//
//  COMMENT!!!
//
//  Created by Jill de Ron on 06-12-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//
// 

import UIKit
import Firebase
import FirebaseAuth

class ChoresTableViewController: UITableViewController {
    
    // MARK: Properties
    var items: [Chores] = []
    let ref = FIRDatabase.database().reference(withPath: "chores-items")
    
    // MARK: Actions
    @IBAction func addButtonDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Chore",
                                      message: "Add a chore",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in

            guard let textField = alert.textFields?.first,
            let text = textField.text else { return }
                                                    
            if textField.text == "" {
               self.alertUser()
            } else {
                let choreItem = Chores(name: text, completed: false)
                
                let choreItemRef = self.ref.child(text.lowercased())
                
                choreItemRef.setValue(choreItem.toAnyObject())
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: Functions
    
    /// Returns which day of the week it is, with 1 being Sunday and 7 being Saturday
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: NSDate() as Date).weekday
    }
    
    /// Makes a completed chore not completed when clicked and the other way around
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.gray
        }
    }
    
    /// Presents an alert with a title, message and candel bottom.
    func alertUser() {
        let alertController = UIAlertController(title: "No chore", message: "Fill in a chore", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Synchronizing Data to table view after view did load.
        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
            
            // Store the latest version of the data in a local variable inside the listener's closure
            var newItems: [Chores] = []
            
            // The listener's closure returns a snapshot of the latest set of data.
            for item in snapshot.children {
                let choreItem = Chores(snapshot: item as! FIRDataSnapshot)
                newItems.append(choreItem)
            }
            
            // Reassign items to the latest version of the data, then reload the table view so it displays
            // the latest version.
            self.items = newItems
            self.tableView.reloadData()
        })

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // only upload cells if the view is loaded
        if items.count != 0 {
            var cells = Array<UITableViewCell?>()
            
            var shouldUpdate = false
            // makes sure the chores are updated on monday
            if dayNumberOfWeek() == 2 {
                shouldUpdate = true
            }
            
            // Go through all the cells
            for index in 0...(items.count-1) {
                let indexPath = IndexPath(row: index, section: 0)
                cells.append(tableView.cellForRow(at: indexPath))
                
                let choreItem = items[indexPath.row]
                
                if shouldUpdate {
                    choreItem.ref?.updateChildValues([
                        "completed": false
                    ])
                } else {
                    return
                }
            }
            
            for cell in cells {
                if shouldUpdate {
                    toggleCellCheckbox(cell!, isCompleted: false)
                }else {
                    return
                }
            }
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let choreItem = items[indexPath.row]
        
        cell.textLabel?.text = choreItem.name
        
        toggleCellCheckbox(cell, isCompleted: choreItem.completed)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let choreItem = items[indexPath.row]
            choreItem.ref?.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let choreItem = items[indexPath.row]
        let toggledCompletion = !choreItem.completed
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        choreItem.ref?.updateChildValues([
            "completed": toggledCompletion
            ])
    }
    

}
