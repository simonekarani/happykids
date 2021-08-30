//
//  MainViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/5/21.
//

import Foundation
import UIKit

class MainViewController: UICollectionViewController {

    let userLicenseAgreement  = """
                                    
                                    Healthier Kids, is an application for helping kids manage stress, wellbeing, and have a healthy lifestyle. The application provides tested methodologies for kids to maintain stress free lifestyle. The application is built for the Healthier Kids Foundation (HKF).
                                    
                                    HKF's mission is to remove barriers impacting the health, learning and life success of Silicon Valley youth.
                                    
                                    The application has been built by Simone Karani, a Saratoga High School student residing in Saratoga, CA in US.
                                    
                                    NOTE: The application does not solve mental health or emotional stress problems. For problems related to mental health, refer to \"Resources\" section in the application, and consult a medical professional.
                                    """
    
    let frontLabelArray = ["Self-Esteem", "Goals & Plans", "Health Programs",
                           "Health Tips", "My Hygiene",  "Resources"]
    let frontImageArray = [
        UIImage(named: "esteem"),
        UIImage(named: "goals"),
        UIImage(named: "kidsprogram"),
        UIImage(named: "dailytips"),
        UIImage(named: "myhygiene"),
        UIImage(named: "resource")
    ]
    var tablefontSize: Int = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize( width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/4)
        
        //        self.navigationController?.navigationBar.titleTextAttributes =
        //            [NSAttributedString.Key.foregroundColor: UIColor.red,
        //             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]
        
        print("frame=\(self.view.frame) , width=\(self.view.frame.width), height=\(self.view.frame.height)")
        
        self.navigationItem.setHidesBackButton(true,  animated:true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let hasAlreadyLaunched :Bool = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        if hasAlreadyLaunched {
            displayLicenAgreement(message: self.userLicenseAgreement)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frontImageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frontCell", for: indexPath) as! MainCollectionViewCell
        
        cell.frontLabel.text = frontLabelArray[indexPath.item]
        cell.frontImage.image = frontImageArray[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "gotoEsteem", sender: self)
            
        case 1:
            performSegue(withIdentifier: "gotoGoalsPlans", sender: self)

        case 2:
            performSegue(withIdentifier: "gotoProgram", sender: self)

        case 3:
            performSegue(withIdentifier: "gotoHealthTips", sender: self)

        case 4:
            performSegue(withIdentifier: "gotoHygiene", sender: self)
            
        case 5:
            performSegue(withIdentifier: "gotoResources", sender: self)
            
        default:
            performSegue(withIdentifier: "gotoRecords", sender: self)
        }
    }
    
    func displayLicenAgreement(message:String){
        
        //create alert
        let alert = UIAlertController(title: "License Agreement", message: message, preferredStyle: .alert)
        
        //create Decline button
        /*let declineAction = UIAlertAction(title: "Decline" , style: .destructive){ (action) -> Void in
            //DECLINE LOGIC GOES HERE
            
        }*/
        
        //create Accept button
        let acceptAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            UserDefaults.standard.set(false, forKey: "hasAlreadyLaunched")
        }
        
        //add task to tableview buttons
        //alert.addAction(declineAction)
        alert.addAction(acceptAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func backFromUnwind(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}
