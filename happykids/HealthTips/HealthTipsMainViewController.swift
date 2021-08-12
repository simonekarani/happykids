//
//  ProgramMainViewController.swift
//  happykids
//
//  Created by Simone Karani on 2/12/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import UIKit

class HealthTipsMainViewController: UIViewController {
    
    @IBOutlet weak var healthTipsTableView: UITableView!
    
    let devCourses = [
        ("Health Affirmation"), ("Healthy Habits"),
        ("Yearly Checkup"), ("Safety Tips")
    ]
    let devCousesImages = [
        UIImage(named: "healthaffirm"), UIImage(named: "healthtips"),
        UIImage(named: "yearlycheck"), UIImage(named: "childsafe")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        self.healthTipsTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.healthTipsTableView.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTableView() {
        healthTipsTableView.delegate = self
        healthTipsTableView.dataSource = self
        
        healthTipsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: "gotoHealthQuote", sender: self)
        case 1:
            performSegue(withIdentifier: "gotoSmileFirst", sender: self)
        case 2:
            performSegue(withIdentifier: "gotoYearlyCheckup", sender: self)
        case 3:
            performSegue(withIdentifier: "gotoSafetyTips", sender: self)
        default:
            performSegue(withIdentifier: "gotoHealthQuote", sender: self)

        }
    }
}

extension HealthTipsMainViewController: UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

extension HealthTipsMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthTipsCell", for: indexPath as IndexPath) as! HealthTipsMainTableViewCell
        
        cell.programImg.image = self.devCousesImages[indexPath .row]
        cell.programLabel.text  = self.devCourses[indexPath .row]
        
        return cell
    }
}
