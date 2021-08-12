//
//  ProgramMainViewController.swift
//  happykids
//
//  Created by Simone Karani on 2/12/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import UIKit

class ProgramMainViewController: UIViewController {

    
    @IBOutlet weak var programTableView: UITableView!
    
    let devCourses = [
        ("10 Steps"), ("SmileFirst"),
        ("DentalFirst"), ("HearingFirst"),
        ("VisionFirst")
    ]
    let devCousesImages = [
        UIImage(named: "10steps"), UIImage(named: "smileFirst"),
        UIImage(named: "dentalFirst"), UIImage(named: "hearingFirst"),
        UIImage(named: "visionFirst"),
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
        programTableView.delegate = self
        programTableView.dataSource = self
        
        programTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: "goto10step", sender: self)
        case 1:
            performSegue(withIdentifier: "gotoSmileFirst", sender: self)
        case 2:
            performSegue(withIdentifier: "gotoDentalFirst", sender: self)
        case 3:
            performSegue(withIdentifier: "gotoHearingFirst", sender: self)
        case 4:
            performSegue(withIdentifier: "gotoVisionFirst", sender: self)
        default:
            performSegue(withIdentifier: "goto10step", sender: self)
            
        }
    }
}

extension ProgramMainViewController: UITableViewDelegate {
    
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

extension ProgramMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "programCell", for: indexPath as IndexPath) as! ProgramMainTableViewCell
        
        cell.programImg.image = self.devCousesImages[indexPath .row]
        cell.programLabel.text  = self.devCourses[indexPath .row]
        
        return cell
    }
}
