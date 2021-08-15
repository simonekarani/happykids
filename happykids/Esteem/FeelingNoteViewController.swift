//
//  FeelingNoteScreenController.swift
//  myHSJournal
//
//  Created by Simone Karani on 2/20/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import DropDown

class FeelingNoteViewController: UIViewController {
    
    @IBOutlet weak var feelingTypeButton: UIButton!
    @IBOutlet weak var feelingTitle: UITextField!
    @IBOutlet weak var feelingDetail: UITextView!
    
    var editEsteemRec: EsteemRecItem!
    var esteemRecCount: Int!

    var recItemArray = [String]()
    var recCreated = false
    var recState: RecState = .NONE

    let feelingDropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()

        feelingDropDown.dataSource = [
            EsteemFeelingType.ANGRY.description, EsteemFeelingType.ANNOYED.description,
            EsteemFeelingType.BORED.description, EsteemFeelingType.EMBARRASSED.description,
            EsteemFeelingType.HAPPY.description, EsteemFeelingType.JEALOUS.description,
            EsteemFeelingType.NERVOUS.description, EsteemFeelingType.SAD.description,
            EsteemFeelingType.SICK.description, EsteemFeelingType.STRESSED.description,
            EsteemFeelingType.SURPRISED.description, EsteemFeelingType.TIRED.description,
            EsteemFeelingType.WORRIED.description
        ]
        feelingDropDown.width = 180

        recCreated = false
        feelingTitle.isUserInteractionEnabled = true
        feelingDetail.isEditable = true

        if (editEsteemRec != nil) {
            feelingTitle.text = editEsteemRec.msgTitle!
            feelingDetail.text = editEsteemRec.message!
            let selectedRow = EsteemFeelingType.toInt(value: editEsteemRec.feelingType!)
            feelingDropDown.selectRow(selectedRow)
            feelingTypeButton.setTitle(feelingDropDown.dataSource[selectedRow], for: .normal)
            recState = .UPDATE
        } else {
            feelingDropDown.selectRow(6)
            feelingTypeButton.setTitle(EsteemFeelingType.HAPPY.description, for: .normal)
            recState = .ADD
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if (recState == .ADD) {
                createRecord()
            } else {
                updateRecord()
            }
        }
        
        if (esteemRecCount == 0 && recCreated == false) {
            let controllersInNavigationCount = self.navigationController?.viewControllers.count
            self.navigationController?.popToViewController(self.navigationController?.viewControllers[controllersInNavigationCount!-2] as! EsteemMainViewController, animated: true)
        }
    }
    
    @IBAction func tapChooseMenuItem(_ sender: UIButton) {
        feelingDropDown.anchorView = sender
        feelingDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        feelingDropDown.show()
        feelingDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal)
        }
    }
    
    func createRecord() {
        if (feelingTitle.text == "" && feelingDetail.text == "") {
            return
        }
        
        recCreated = true
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let esteemRecItem = EsteemRecItem(context: context)
        esteemRecItem.esteemType = EsteemType.FEELING.description
        esteemRecItem.feelingType = feelingDropDown.selectedItem
        esteemRecItem.timeMillis = getCurrentMillis()
        esteemRecItem.date = Date().getFormattedDate(format: "MM/dd/yyyy")
        esteemRecItem.msgTitle = feelingTitle.text
        esteemRecItem.message = feelingDetail.text
        saveContext()
    }
    
    func updateRecord() {
        var esteemItemArray = [EsteemRecItem]()
        let request: NSFetchRequest<EsteemRecItem> = EsteemRecItem.fetchRequest()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            esteemItemArray = try context.fetch(request)
            var isFound: Bool = false
            for (_, element) in esteemItemArray.enumerated() {
                if (element.timeMillis == editEsteemRec.timeMillis) {
                    element.feelingType = feelingDropDown.selectedItem
                    element.msgTitle = feelingTitle.text
                    element.message = feelingDetail.text
                    saveContext()
                    isFound = true
                    return
                }
            }
            if !isFound {
                createRecord()
            }
        } catch {
            print("Error in loading \(error)")
        }
    }
    
    func saveContext() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func getCurrentMillis()->Int64{
        return  Int64(NSDate().timeIntervalSince1970 * 1000)
    }
}
