//
//  Step10ViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/17/21.
//

import UIKit
import DropDown
import youtube_ios_player_helper

class Step10ViewController: UIViewController {

    @IBOutlet weak var email10step: UILabel!
    @IBOutlet weak var phone10step: UILabel!
    
    let rightBarDropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()

        email10step.isUserInteractionEnabled = true
        phone10step.isUserInteractionEnabled = true
        
        setupLabelInteractions()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showBarButtonDropDown))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        rightBarDropDown.anchorView = addBarButtonItem
        rightBarDropDown.dataSource = ["Resources", "Workshop"]
        rightBarDropDown.cellConfiguration = { (index, item) in return "\(item)" }
    }
    
    @IBAction func showBarButtonDropDown(_ sender: AnyObject) {

       rightBarDropDown.selectionAction = {
        (index: Int, item: String) in
        if index == 0 {
            self.performSegue(withIdentifier: "gotoStep10Resources", sender: self)
        } else {
            self.performSegue(withIdentifier: "gotoWorkshop", sender: self)
        }
       }

       rightBarDropDown.width = 140
       rightBarDropDown.bottomOffset = CGPoint(x: 0, y:(rightBarDropDown.anchorView?.plainView.bounds.height)!)
       rightBarDropDown.show()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupLabelInteractions() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(callEmail10Clicked(_:)))
        gesture1.numberOfTapsRequired = 1
        email10step.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(callPhone10Clicked(_:)))
        gesture2.numberOfTapsRequired = 1
        phone10step.addGestureRecognizer(gesture2)
    }
    
    @objc func callEmail10Clicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://8553446347"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }

    @objc func callPhone10Clicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://8553446347"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
