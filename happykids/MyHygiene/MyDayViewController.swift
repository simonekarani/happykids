//
//  MyDayViewController.swift
//  myHSJournal
//
//  Created by Simone Karani on 2/21/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import CoreData
import Foundation
import UIKit

enum MyDayStatusType: Int {
    case HOORAY_TYPE = 0
    case YAY_TYPE = 1
    case MEH_TYPE = 2
    case OOPS_TYPE = 3
    case YIKES_TYPE = 4

    var description : String {
      switch self {
          // Use Internationalization, as appropriate.
          case .HOORAY_TYPE: return "hooray"
          case .YAY_TYPE: return "yay"
          case .MEH_TYPE: return "meh"
          case .OOPS_TYPE: return "oops"
          case .YIKES_TYPE: return "yikes"
      }
    }
}

class MyDayViewController: UIViewController {
    
    @IBOutlet weak var dayViewTblView: UITableView!
    
    var myDayItemArray = [MyDayRecItem]()

    let dayLabelArray = ["Hooray", "Yay", "Meh",
                           "Oops", "Yikes"]
    let dayImageArray = [
        UIImage(named: "hooray"),
        UIImage(named: "yay"),
        UIImage(named: "meh"),
        UIImage(named: "oops"),
        UIImage(named: "yikes")
    ]
    var howMyDayIndex:Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMyDayRecords()
        setupTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Past",
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMyDayRecords()
        DispatchQueue.main.async {
            self.dayViewTblView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTableView() {
        dayViewTblView.allowsSelection = true
        dayViewTblView.allowsSelectionDuringEditing = true
        
        dayViewTblView.delegate = self
        dayViewTblView.dataSource = self
        
        dayViewTblView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
    
    func loadMyDayRecords() {
        myDayItemArray.removeAll()
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            let request: NSFetchRequest<MyDayRecItem> = MyDayRecItem.fetchRequest()
            do {
                myDayItemArray = try context.fetch(request)
            } catch {
                print("Error in loading \(error)")
            }
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "gotoPastMyDay", sender: self)
    }
}

extension MyDayViewController: UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dStr: String = Date().getFormattedDate(format: "MM/dd/yyyy")
        var updtItemArray = [MyDayRecItem]()
        let request: NSFetchRequest<MyDayRecItem> = MyDayRecItem.fetchRequest()
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
                if element.dayDate == dStr {
                    element.howStatus = dayLabelArray[indexPath.row]
                    isFound = true
                }
            }
            if !isFound {
                if #available(iOS 10.0, *) {
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let plansRecItem = MyDayRecItem(context: context)
                    plansRecItem.timeMillis = getCurrentMillis()
                    plansRecItem.dayDate = Date().getFormattedDate(format: "MM/dd/yyyy")
                    plansRecItem.howStatus = dayLabelArray[indexPath.row]
                } else {
                    _ = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                    let plansRecItem = MyDayRecItem()
                    plansRecItem.timeMillis = getCurrentMillis()
                    plansRecItem.dayDate = Date().getFormattedDate(format: "MM/dd/yyyy")
                    plansRecItem.howStatus = dayLabelArray[indexPath.row]
                }
            }
        } catch {
            print("Error in loading \(error)")
        }
       saveContext()
        
        loadMyDayRecords()
        DispatchQueue.main.async {
            self.dayViewTblView.reloadData()
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

protocol MyDayTableViewCellDelegate: AnyObject {
    func toggleCheckmark(for cell: DidIDoTableViewCell)
    func updateTableView()
}

extension MyDayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mydayCell", for: indexPath as IndexPath) as! DidIDoTableViewCell
        cell.configureCell(cellText: self.dayLabelArray[indexPath .row], cellImg: self.dayImageArray[indexPath .row]!)
        //cell.todoBtn.addTarget(self, action: #selector(DailyPlanViewController.onClickedMapButton(_:)), for: .touchUpInside)
        // Set up cell
        cell.delegate = self

        return cell
    }
}

extension MyDayViewController: MyDayTableViewCellDelegate {
    func toggleCheckmark(for cell: DidIDoTableViewCell) {
        let totalSection = dayViewTblView.numberOfSections
        for section in 0..<totalSection {
            let totalRows = dayViewTblView.numberOfRows(inSection: section)

            for row in 0..<totalRows {
                let cell:DidIDoTableViewCell = dayViewTblView.cellForRow(at: IndexPath(row: row, section: section)) as! DidIDoTableViewCell
                if cell.isCheckSelected! == false {
                    cell.checkBtn.isSelected = false
                }
            }
        }
    }
    
    func updateTableView() {
        let totalSection = dayViewTblView.numberOfSections
        for section in 0..<totalSection {
            let totalRows = dayViewTblView.numberOfRows(inSection: section)

            for row in 0..<totalRows {
                let cell:DidIDoTableViewCell = dayViewTblView.cellForRow(at: IndexPath(row: row, section: section)) as! DidIDoTableViewCell
                if cell.isCheckSelected! {
                    howMyDayIndex = row
                }
            }
        }
        loadMyDayRecords()
        DispatchQueue.main.async {
            self.dayViewTblView.reloadData()
        }
    }
}
