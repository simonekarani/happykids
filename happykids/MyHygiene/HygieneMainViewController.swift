//
//  HygieneMainViewController.swift
//  happykids
//
//  Created by Simone Karani on 2/12/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import UIKit

class HygieneMainViewController: UIViewController {

    
    @IBOutlet weak var hygieneTableView: UITableView!
    
    let devCourses = [
        ("How I did Today"), ("Morning Routine"),
        ("Afternoon Routine"), ("Evening Routine"),
        ("Good Deeds Today")
    ]
    let devCousesImages = [
        UIImage(named: "howDidIDo"), UIImage(named: "morning"),
        UIImage(named: "afternoon"), UIImage(named: "night"),
        UIImage(named: "deeds")
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
        hygieneTableView.delegate = self
        hygieneTableView.dataSource = self
        
        hygieneTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: "gotoDidIDo", sender: self)
        case 1:
            performSegue(withIdentifier: "gotoMorningRoutine", sender: self)
        case 2:
            performSegue(withIdentifier: "gotoAfternoonRoutine", sender: self)
        case 3:
            performSegue(withIdentifier: "gotoEveningRoutine", sender: self)
        case 4:
            performSegue(withIdentifier: "gotoDeeds", sender: self)
        default:
            performSegue(withIdentifier: "gotoDidIDo", sender: self)
            
        }
    }
}

extension HygieneMainViewController: UITableViewDelegate {
    
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

extension HygieneMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myhygieneCell", for: indexPath as IndexPath) as! HygieneMainTableViewCell
        
        cell.hygieneImg.image = self.devCousesImages[indexPath .row]
        cell.hygieneLabel.text  = self.devCourses[indexPath .row]
        
        return cell
    }
}
