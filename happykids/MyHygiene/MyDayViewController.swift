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

class MyDayViewController: UIViewController {
    
    @IBOutlet weak var dayViewTblView: UITableView!
    
    let dayLabelArray = ["Hooray", "Yay", "Meh",
                           "Oops", "Yikes"]
    let dayImageArray = [
        UIImage(named: "hooray"),
        UIImage(named: "yay"),
        UIImage(named: "meh"),
        UIImage(named: "oops"),
        UIImage(named: "yikes")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTableView() {
        dayViewTblView.delegate = self
        dayViewTblView.dataSource = self
        
        dayViewTblView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
    
    func loadMyDayRecords() {
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
        
        let checkImg = UIImage(named: "checkempty")
        cell.checkBtn.setImage(checkImg , for: UIControl.State.normal)
        
        cell.didImg.image = self.dayImageArray[indexPath .row]
        cell.didText.text  = self.dayLabelArray[indexPath .row]
        cell.didText.backgroundColor = UIColor.clear
        
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
                let checkImg = UIImage(named: "checkempty")
                cell.checkBtn.setImage(checkImg , for: UIControl.State.normal)
            }
        }
    }
    
    func updateTableView() {
        loadMyDayRecords()
        DispatchQueue.main.async {
            self.dayViewTblView.reloadData()
        }
    }
}
