//
//  Step10WorkshopViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/17/21.
//

import UIKit

class Step10WorkshopViewController: UIViewController {

    let workshop1Content: String = "\nWorkshop focuses on lifestyle habits rather than body shape or weight; presents PHLC’s 10 Steps to a Healthier You! lifestyle recommendations for family; and discusses the process of behavior change"
    let workshop2Content: String = "\nWorkshop content focuses on an experiential approach to establishing structure in the home related to mealtime and bedtime routines to support implementation of the 10 Steps to a Healthier You!"
    let workshop3Content: String = "\nWorkshop content focuses on Division of Responsibility for feeding young children where participants experience child’s perspective of being restricted or forced to eat"
    let workshop4Content: String = "\nWorkshop content focuses on empowering and supporting caregivers who have finished the 3-part series to continue practicing healthy habits. This workshop was developed based on interviews conducted to participants 4-6 weeks after finishing the program"

    @IBOutlet weak var registerCallLabel: UILabel!
    @IBOutlet weak var workshop1Text: UITextView!
    @IBOutlet weak var workshop2Text: UITextView!
    @IBOutlet weak var workshop3Text: UITextView!
    @IBOutlet weak var workshop4Text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLabelInteractions()
        registerCallLabel.isUserInteractionEnabled = true
    }
    
    func setupLabelInteractions() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(callPhone10Clicked(_:)))
        gesture1.numberOfTapsRequired = 1
        registerCallLabel.addGestureRecognizer(gesture1)
        
        setWorkshopText()
    }

    func setWorkshopText() {
        setWorkshop1Text()
        setWorkshop2Text()
        setWorkshop3Text()
        setWorkshop4Text()
    }
    
    func setWorkshop1Text() {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)
        ]
        let boldText = NSAttributedString(string: "Workshop 1\n10 Steps to Healthier You", attributes: boldAttribute)
        let regularText = NSAttributedString(string: workshop1Content, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        
        workshop1Text.attributedText = newString
    }
    
    func setWorkshop2Text() {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)
        ]
        let boldText = NSAttributedString(string: "Workshop 2\nStructures and Routines", attributes: boldAttribute)
        let regularText = NSAttributedString(string: workshop2Content, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        
        workshop2Text.attributedText = newString
    }

    func setWorkshop3Text() {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)
        ]
        let boldText = NSAttributedString(string: "Workshop 3\n5 keys Raising Healthy, Happy Eater", attributes: boldAttribute)
        let regularText = NSAttributedString(string: workshop3Content, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        
        workshop3Text.attributedText = newString
    }

    func setWorkshop4Text() {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)
        ]
        let boldText = NSAttributedString(string: "Workshop 4\nBoosting Healthy Habits", attributes: boldAttribute)
        let regularText = NSAttributedString(string: workshop3Content, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        
        workshop4Text.attributedText = newString
    }

    @objc func callPhone10Clicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://18553446347"),
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
