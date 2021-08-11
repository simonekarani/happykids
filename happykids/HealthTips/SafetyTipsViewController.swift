//
//  SafetyTipsViewController.swift
//  happykids
//
//  Created by Simone Karani on 8/10/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import CoreData
import Foundation
import UIKit

class SafetyTipsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let NoGoalMessage: String = "\nNo Safety Tips Found"

    let safetyTypeArray = ["Covid", "Online", "Personal"]
    let covidTipsArray = [
        "Wash your hands for 20 seconds. Sing a short song while you scrub",
        "Visit your friends from home. Do play dates meet-up using computer or phone",
        "Masks are safe. They help protect from germs",
        "Cover your cough or sneeze",
        "Practice social distancing in waiting rooms and check-in lines",
        "Feeling sick, Inform parent and stay at home",
        "Avoid touching your eyes, nose and mouth with unwashed hands"
    ]
    let onlineTipsArray = [
        "Do not share personal phone number, or birthdate or school information online",
        "Don’t talk to strangers on the Internet",
        "Don’t agree to meet anyone in person that you’ve met online",
        "Don’t post pictures of yourself without your parents’ permission",
        "Do not download or install anything on your computer without your parents’ permission",
        "If you are talking to someone online and they make you uncomfortable, remember you don’t have to talk back to them",
        "Online Ads - Don’t buy anything online without talking to your parents first",
        "Bullying - Don’t send or respond to mean or insulting messages"
    ]
    let personalTipsArray =
        ["In case of an emergency, dial 911",
         "Wear helmet while riding a bike, skateboard, or scooter, and ride during daytime",
         "During car ride use seat belt, and ride in back seat of car until 8 to 12 years of age",
         "While crossing street look both ways, and listen for car sounds",
         "Apply sunscreen of SPF 30 or higher at least 15 minutes before going outside in sun, and reapply every 2 hours",
         "Never play with knives, guns or any other dangerous weapons",
         "Know the difference between good touch and bad touch, scream for help if feeling violated in any way"]

    @IBOutlet weak var safetyTipsTableView: UITableView!
    
    var selectedBtnTag: Int!
    var editGoalsTodoRec: SafetyTipRecItem!
    
    var goalsTodoAllItemArray = [SafetyTipRecItem]()
    var deedsList = [String]()
    var todoView: TodoViewType!
    var todoStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoView = .TODO_ACTIVE
        loadSafetyRecords()
        if goalsTodoAllItemArray.count == 0 {
            createSafetyRecords()
            loadSafetyRecords()
        }
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTypeTapped)
        )
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSafetyRecords()
        DispatchQueue.main.async {
            self.safetyTipsTableView.reloadData() }
    }
    
    @IBAction func addTypeTapped(_ sender: Any) {
        addTypeDialog(msg: "")
    }
    
    @objc func onPlusClickedMapButton(_ sender: UIButton) {
        selectedBtnTag = sender.tag
        addTipDialog(msg: "", sType: deedsList[selectedBtnTag])
    }
    
    @objc func onClickedMapButton(_ sender: UIButton) {
        saveContext()
    }
    
    func addTypeDialog(msg: String) {
        let alert = UIAlertController(title: "Safety Type", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Default placeholder text"
        }
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            self.todoStr = userText
            self.createTypeRecord()
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addTipDialog(msg: String, sType: String) {
        var recExists = false
        let alert = UIAlertController(title: "Safety Tips", message: nil, preferredStyle: .alert)
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
                self.updateRecord(safetyType: sType)
            } else {
                self.createRecord(safetyType: sType)
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupTableView() {
        safetyTipsTableView.allowsSelection = true
        safetyTipsTableView.allowsSelectionDuringEditing = true
        
        safetyTipsTableView.delegate = self
        safetyTipsTableView.dataSource = self
        
        // Set automatic dimensions for row height
        safetyTipsTableView.rowHeight = UITableView.automaticDimension
        safetyTipsTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.safetyTipsTableView.register(UINib.init(nibName: "GoalPlanTableViewCell", bundle: .main), forCellReuseIdentifier: "GoalPlanTableViewCell")
        self.safetyTipsTableView.register(UINib.init(nibName: "DailyTodoTableViewCell", bundle: .main), forCellReuseIdentifier: "DailyTodoTableViewCell")
        
        safetyTipsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func loadSafetyRecords() {
        goalsTodoAllItemArray.removeAll()
        let request: NSFetchRequest<SafetyTipRecItem> = SafetyTipRecItem.fetchRequest()
        do {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                goalsTodoAllItemArray = try context.fetch(request)
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                goalsTodoAllItemArray = try context.fetch(request)
            }
        } catch {
            print("Error in loading \(error)")
        }
    }
    
    func createSafetyRecords() {
        for i in 0 ..< safetyTypeArray.count {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let typeRecItem = SafetyTypeRecItem(context: context)
                typeRecItem.timeMillis = getCurrentMillis()
                typeRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
                typeRecItem.safetyType = safetyTypeArray[i]
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                let typeRecItem = SafetyTypeRecItem()
                typeRecItem.timeMillis = getCurrentMillis()
                typeRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
                typeRecItem.safetyType = safetyTypeArray[i]
            }
            saveContext()
        }
        createSafetyTipRecords(sTipArray: covidTipsArray, sType: safetyTypeArray[0])
        createSafetyTipRecords(sTipArray: onlineTipsArray, sType: safetyTypeArray[1])
        createSafetyTipRecords(sTipArray: personalTipsArray, sType: safetyTypeArray[2])
    }
    
    func createSafetyTipRecords(sTipArray: [String], sType: String) {
        for i in 0 ..< sTipArray.count {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let tipRecItem = SafetyTipRecItem(context: context)
                tipRecItem.timeMillis = getCurrentMillis()
                tipRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
                tipRecItem.safetyType = sType
                tipRecItem.safetyTip = sTipArray[i]
                tipRecItem.completed = false
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                let tipRecItem = SafetyTipRecItem()
                tipRecItem.timeMillis = getCurrentMillis()
                tipRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
                tipRecItem.safetyType = sType
                tipRecItem.safetyTip = sTipArray[i]
                tipRecItem.completed = false
            }
            saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRecordCount(numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("** row = \(indexPath.row) section = \(indexPath.section) count=\(indexPath.count)")
        if (goalsTodoAllItemArray.count == 0) {
            let cell: GoalPlanTableViewCell = safetyTipsTableView.dequeueReusableCell(withIdentifier: "GoalPlanTableViewCell", for: indexPath) as! GoalPlanTableViewCell
            cell.configureCell(section: indexPath.section, lblText: getGoalTitle(section: indexPath.section))
            cell.addBtn.addTarget(self, action: #selector(onPlusClickedMapButton(_:)), for: .touchUpInside)
            cell.addBtn.tag = indexPath.section
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        let recCount: Int = getRecordCount(numberOfRowsInSection: indexPath.section)
        if recCount > 0 {
            if indexPath.row == 0 {
                let cell: GoalPlanTableViewCell = safetyTipsTableView.dequeueReusableCell(withIdentifier: "GoalPlanTableViewCell", for: indexPath) as! GoalPlanTableViewCell
                cell.configureCell(section: indexPath.section, lblText: getGoalTitle(section: indexPath.section))
                cell.addBtn.addTarget(self, action: #selector(onPlusClickedMapButton(_:)), for: .touchUpInside)
                cell.addBtn.tag = indexPath.section
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            } else {
                let cell: DailyTodoTableViewCell = safetyTipsTableView.dequeueReusableCell(withIdentifier: "DailyTodoTableViewCell", for: indexPath) as! DailyTodoTableViewCell
                let yearlyItem: SafetyTipRecItem = getRecord(actionForRowAt: indexPath)!
                cell.configureCell(recItem: yearlyItem)
                cell.todoBtn.addTarget(self, action: #selector(DailyPlanViewController.onClickedMapButton(_:)), for: .touchUpInside)
                return cell
            }
        }
        else {
            let cell: DailyTodoTableViewCell = safetyTipsTableView.dequeueReusableCell(withIdentifier: "DailyTodoTableViewCell", for: indexPath) as! DailyTodoTableViewCell
            cell.todoBtn.addTarget(self, action: #selector(DailyPlanViewController.onClickedMapButton(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if (indexPath.row == 0) {
            return []
        }
        editGoalsTodoRec = getRecord(actionForRowAt: indexPath)!
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { [self] (action, indexPath) in
            self.addTipDialog(msg: self.editGoalsTodoRec.safetyTip!, sType: deedsList[indexPath.section])
        })
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            // Declare Alert message
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete the record\n\(self.editGoalsTodoRec.safetyTip!)?", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                self.deletePlanRecord(deleteActionForRowAt: indexPath, recitem: self.editGoalsTodoRec)
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
    
    func createNoGoalAlertAction(message: String) {
        let alert = UIAlertController(title: "Plans for Goals!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)

        })))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if goalsTodoAllItemArray.count == 0 || indexPath.row == 0 {
            return
        }
        self.editGoalsTodoRec = getRecord(actionForRowAt: indexPath)!
        self.addTipDialog(msg: self.editGoalsTodoRec.safetyTip!, sType: deedsList[indexPath.section])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if goalsTodoAllItemArray.count == 0 {
            return 1
        } else {
            var goodDeedSet = Set<String>()
            for elem in goalsTodoAllItemArray {
                if elem.safetyType == nil {
                    goodDeedSet.insert(elem.safetyTip!)
                } else {
                    goodDeedSet.insert(elem.safetyType!)
                }
            }
            if deedsList.count <= goodDeedSet.count {
                deedsList = Array(goodDeedSet)
            }
            return deedsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func getGoalTitle(section: Int) -> String {
        if goalsTodoAllItemArray.count == 0 {
            return safetyTypeArray[0]
        } else {
            return deedsList[section]
        }
    }
    
    func getRecordCount(numberOfRowsInSection section: Int) -> Int {
        // add 1 for each section heading
        if goalsTodoAllItemArray.count == 0 {
            return 1
        }
        let dateSection: String = deedsList[section]
        var rowCount: Int = 1
        for (_, element) in goalsTodoAllItemArray.enumerated() {
            if element.safetyType == dateSection {
                rowCount += 1
            }
        }
        return rowCount
    }
    
    func getRecord(actionForRowAt indexPath: IndexPath) -> SafetyTipRecItem? {
        var idxCount: Int = 0
        let dateSection: String = deedsList[indexPath.section]
        for (_, element) in goalsTodoAllItemArray.enumerated() {
            if element.safetyType == dateSection {
                if indexPath.row-1 == idxCount {
                    return element
                }
                idxCount += 1
            }
        }
        return nil
    }
    
    func deletePlanRecord(deleteActionForRowAt indexPath: IndexPath, recitem: SafetyTipRecItem) {
        deleteRecord(timeMillis: recitem.timeMillis)
        loadSafetyRecords()
        DispatchQueue.main.async {
            self.safetyTipsTableView.reloadData() }
    }
    
    func deleteRecord(timeMillis: Int64) {
        let request: NSFetchRequest<SafetyTipRecItem> = SafetyTipRecItem.fetchRequest()
        do {
            if #available(iOS 10.0, *) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                goalsTodoAllItemArray = try context.fetch(request)
                for (_, element) in goalsTodoAllItemArray.enumerated() {
                    if (element.timeMillis == timeMillis) {
                        context.delete(element)
                        saveContext()
                        return
                    }
                }
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                goalsTodoAllItemArray = try context.fetch(request)
                for (_, element) in goalsTodoAllItemArray.enumerated() {
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
    
    func createTypeRecord() {
        if todoStr == "" {
            return
        }
        
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let plansRecItem = SafetyTypeRecItem(context: context)
            plansRecItem.timeMillis = getCurrentMillis()
            plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
            plansRecItem.safetyType = todoStr
        } else {
            _ = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            let plansRecItem = SafetyTypeRecItem()
            plansRecItem.timeMillis = getCurrentMillis()
            plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
            plansRecItem.safetyType = todoStr
        }
        deedsList.append(todoStr)
        
        saveContext()
        
        loadSafetyRecords()
        DispatchQueue.main.async {
            self.safetyTipsTableView.reloadData() }
    }
    
    func createRecord(safetyType: String) {
        if todoStr == "" {
            return
        }
        
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let plansRecItem = SafetyTipRecItem(context: context)
            plansRecItem.timeMillis = getCurrentMillis()
            plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
            plansRecItem.safetyType = safetyType
            plansRecItem.safetyTip = todoStr
            plansRecItem.completed = false
        } else {
            _ = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            let plansRecItem = SafetyTipRecItem()
            plansRecItem.timeMillis = getCurrentMillis()
            plansRecItem.dateStr = Date().getFormattedDate(format: "MM/dd/yyyy")
            plansRecItem.safetyType = safetyType
            plansRecItem.safetyTip = todoStr
            plansRecItem.completed = false
        }
        
        saveContext()
        
        loadSafetyRecords()
        DispatchQueue.main.async {
            self.safetyTipsTableView.reloadData() }
    }
    
    func updateRecord(safetyType: String) {
        var updtItemArray = [GoalPlanRecItem]()
        let request: NSFetchRequest<GoalPlanRecItem> = GoalPlanRecItem.fetchRequest()
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
                if (element.timeMillis == editGoalsTodoRec.timeMillis) {
                    element.taskDetails = todoStr
                    saveContext()
                    isFound = true
                    loadSafetyRecords()
                    DispatchQueue.main.async {
                        self.safetyTipsTableView.reloadData() }
                    return
                }
            }
            if !isFound {
                createRecord(safetyType: safetyType)
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

extension SafetyTipsViewController: GrowingCellProtocol {
    // Update height of UITextView based on string height
    func updateHeightOfRow(_ cell: RecDetailTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = safetyTipsTableView.sizeThatFits(CGSize(width: size.width,
                                                              height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            safetyTipsTableView?.beginUpdates()
            safetyTipsTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            // Scoll up your textview if required
            if let thisIndexPath = safetyTipsTableView.indexPath(for: cell) {
                safetyTipsTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
