//
//  MainViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/5/21.
//

import Foundation
import UIKit

class MainViewController: UICollectionViewController {

    let frontLabelArray = ["Self-Esteem", "Goals & Plans", "Health Program",
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
    
    
    @IBAction func backFromUnwind(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}
