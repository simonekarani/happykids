//
//  HealthTipsViewController.swift
//  happykids
//
//  Created by Simone Karani on 8/10/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import CoreData
import Foundation
import UIKit

class HealthyHabitsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let healthyHabitsArray = [
        "Stay positive - Read affirmation of the day",
        "Kids 4-8 years old drink around 5 cups, and older kids 7-8 cups of water",
        "Don't skip breakfast",
        "Make half of your meal with fruits and vegetables",
        "Eat meals together as a family. Eat at the table and not in front of television",
        "Look at food nutrition labels for amount of - grams of sugar, calories, saturated fats",
        "Pick enjoyable physical activities like gymnastics, swimming, or archery",
        "Make 30 min reading a part of every day bedtime activity",
        "Brush your teeth twice a day and floss once a day",
        "Spend time socicalizing with friends",
        "Prioritize sleep - Kids 7-12 years sleep 10-11 hours a day, and 12-18 years sleep 8-9 hours a day"
    ]
    
    @IBOutlet weak var healthyHabitsTableView: UITableView!
    
    var editTodoRec: HealthyHabitRecItem!
    var dailyTodoRecCount: Int!
    var todoStr: String!
    
    var healthyHabitsItemArray = [HealthyHabitRecItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHealthyHabitRecords()
        if healthyHabitsItemArray.count == 0 {
            createHealthyHabitRecords()
            loadHealthyHabitRecords()
        }
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        loadHealthyHabitRecords()
        DispatchQueue.main.async {
            self.healthyHabitsTableView.reloadData() }
    }
    
    func setupTableView() {
        healthyHabitsTableView.allowsSelection = true
        healthyHabitsTableView.allowsSelectionDuringEditing = true
        
        healthyHabitsTableView.delegate = self
        healthyHabitsTableView.dataSource = self
        
        // Set automatic dimensions for row height
        healthyHabitsTableView.rowHeight = 50
        healthyHabitsTableView.estimatedRowHeight = UITableView.automaticDimension

        
        self.healthyHabitsTableView.register(UINib.init(nibName: "DailyTodoTableViewCell", bundle: .main), forCellReuseIdentifier: "DailyTodoTableViewCell")
        
        healthyHabitsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @IBAction func addTapped(_ sender: Any) {
        addTodoDialog(msg: "")
    }
    
    @objc func onClickedMapButton(_ sender: UIButton) {
        saveContext()
    }

    func addTodoDialog(msg: String) {
        var recExists = false
        let alert = UIAlertController(title: "Healthy Habits", message: nil, preferredStyle: .alert)
        if msg == "" {
            alert.addTextField { (textField) in
                textField.placeholder = "Default placeholder text"
            }
        } else {
            alert.addTextField { (textField) in
                textField.text = msg
                recExists = true
            }
        }
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            self.todoStr = userText
            if recExists {
                self.updateRecord()
            } else {
                self.createRecord()
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadHealthyHabitRecords() {
        healthyHabitsItemArray.removeAll()
        do {
            let request: NSFetchRequest<HealthyHabitRecItem> = HealthyHabitRecItem.fetchRequest()
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                healthyHabitsItemArray = try context.fetch(request)
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                healthyHabitsItemArray = try context.fetch(request)
            }
        } catch {
            print("Error in loading \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRecordCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DailyTodoTableViewCell = healthyHabitsTableView.dequeueReusableCell(withIdentifier: "DailyTodoTableViewCell", for: indexPath) as! DailyTodoTableViewCell
        cell.configureCell(recItem: healthyHabitsItemArray[indexPath.row])
        cell.todoBtn.addTarget(self, action: #selector(onClickedMapButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if healthyHabitsItemArray.count == 0 {
            return []
        }
        editTodoRec = getRecord(actionForRowAt: indexPath)!
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            self.addTodoDialog(msg: self.editTodoRec.habit!)
        })
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            // Declare Alert message
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete the record \(self.editTodoRec.habit!)?", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                self.deletePlanRecord(deleteActionForRowAt: indexPath, recitem: self.editTodoRec)
            })
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
            }
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        })
        deleteAction.backgroundColor = UIColor.red
        return [editAction, deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if healthyHabitsItemArray.count == 0 {
            return
        }
        self.editTodoRec = getRecord(actionForRowAt: indexPath)!
        self.addTodoDialog(msg: self.editTodoRec.habit!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func getRecordCount() -> Int {
        return healthyHabitsItemArray.count
    }
    
    func getRecord(actionForRowAt indexPath: IndexPath) -> HealthyHabitRecItem? {
        return healthyHabitsItemArray[indexPath.row]
    }
    
    func deletePlanRecord(deleteActionForRowAt indexPath: IndexPath, recitem: HealthyHabitRecItem) {
        if (indexPath.section == 0) {
            healthyHabitsItemArray.remove(at: indexPath.row)
            deleteRecord(timeMillis: recitem.timeMillis)
            loadHealthyHabitRecords()
            DispatchQueue.main.async {
                self.healthyHabitsTableView.reloadData() }
        }
    }
    
    func deleteRecord(timeMillis: Int64) {
        let request: NSFetchRequest<HealthyHabitRecItem> = HealthyHabitRecItem.fetchRequest()
        do {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                healthyHabitsItemArray = try context.fetch(request)
                for (_, element) in healthyHabitsItemArray.enumerated() {
                    if (element.timeMillis == timeMillis) {
                        context.delete(element)
                        saveContext()
                        return
                    }
                }
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                healthyHabitsItemArray = try context.fetch(request)
                for (_, element) in healthyHabitsItemArray.enumerated() {
                    if (element.timeMillis == timeMillis) {
                        context.delete(element)
                        saveContext()
                        return
                    }
                }
            }
        } catch {
            print("Error in loading \(error)")
        }
    }
    
    func createHealthyHabitRecords() {
        for i in 0 ..< healthyHabitsArray.count {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let plansRecItem = HealthyHabitRecItem(context: context)
                plansRecItem.timeMillis = getCurrentMillis()
                plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
                plansRecItem.habit = healthyHabitsArray[i]
                plansRecItem.completed = false
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                let plansRecItem = HealthyHabitRecItem()
                plansRecItem.timeMillis = getCurrentMillis()
                plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
                plansRecItem.habit = healthyHabitsArray[i]
                plansRecItem.completed = false
            }
            saveContext()
        }
    }
    
    func createRecord() {
        if todoStr == "" {
            return
        }
        
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let plansRecItem = HealthyHabitRecItem(context: context)
            plansRecItem.timeMillis = getCurrentMillis()
            plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
            plansRecItem.habit = todoStr
            plansRecItem.completed = false
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            let plansRecItem = HealthyHabitRecItem()
            plansRecItem.timeMillis = getCurrentMillis()
            plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
            plansRecItem.habit = todoStr
            plansRecItem.completed = false
        }
        saveContext()

        loadHealthyHabitRecords()
        DispatchQueue.main.async {
            self.healthyHabitsTableView.reloadData() }
    }
    
    func updateRecord() {
        var updtItemArray = [HealthyHabitRecItem]()
        let request: NSFetchRequest<HealthyHabitRecItem> = HealthyHabitRecItem.fetchRequest()
        do {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                updtItemArray = try context.fetch(request)
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                updtItemArray = try context.fetch(request)
            }
            
            var isFound: Bool = false
            for (_, element) in updtItemArray.enumerated() {
                if (element.timeMillis == editTodoRec.timeMillis) {
                    element.habit = todoStr
                    saveContext()
                    isFound = true
                    loadHealthyHabitRecords()
                    DispatchQueue.main.async {
                        self.healthyHabitsTableView.reloadData() }
                    return
                }
            }
            if !isFound {
                createRecord()
            }
        } catch {
            print("Error in loading \(error)")
        }
    }
    
    func saveContext() {
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }

    func getCurrentMillis()->Int64{
        return  Int64(NSDate().timeIntervalSince1970 * 1000)
    }
}

extension HealthyHabitsViewController: GrowingCellProtocol {
    // Update height of UITextView based on string height
    func updateHeightOfRow(_ cell: RecDetailTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = healthyHabitsTableView.sizeThatFits(CGSize(width: size.width,
                                                              height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            healthyHabitsTableView?.beginUpdates()
            healthyHabitsTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            // Scoll up your textview if required
            if let thisIndexPath = healthyHabitsTableView.indexPath(for: cell) {
                healthyHabitsTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
