//
//  DailyTodoTableViewCell.swift
//  happykids
//
//  Created by Simone Karani on 2/28/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import UIKit

class DailyTodoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoBtn: UIButton!
    @IBOutlet weak var todoTask: UILabel!
    
    var planRecType: Int = 0
    var planRecItem:DailyPlanRecItem!
    var goalPlanRecItem:GoalPlanRecItem!
    var morningRecItem:MorningRecItem!
    var eveningRecItem:EveningRecItem!
    var afternoonRecItem:AfternoonRecItem!
    var deedsRecItem:DeedsRecItem!

    override func awakeFromNib() {
        super.awakeFromNib()
        todoBtn.setImage(UIImage(named:"checkempty"), for: .normal)
        todoBtn.setImage(UIImage(named:"checkmark"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(recItem: DailyPlanRecItem) {
        planRecType = 1
        todoTask.text = recItem.taskDetails!
        if recItem.completed {
            todoBtn.isSelected = true
        } else {
            todoBtn.isSelected = false
        }
        todoBtn.transform = .identity
        planRecItem = recItem

        setupCellDetails()
    }
    
    func configureCell(recItem: GoalPlanRecItem) {
        planRecType = 3
        todoTask.text = recItem.taskDetails!
        if recItem.completed {
            todoBtn.isSelected = true
        } else {
            todoBtn.isSelected = false
        }
        todoBtn.transform = .identity
        goalPlanRecItem = recItem
        
        setupCellDetails()
    }
    
    func configureCell(recItem: MorningRecItem) {
        planRecType = 4
        todoTask.text = recItem.routine!
        if recItem.completed {
            todoBtn.isSelected = true
        } else {
            todoBtn.isSelected = false
        }
        todoBtn.transform = .identity
        morningRecItem = recItem
        
        setupCellDetails()
    }
    
    func configureCell(recItem: EveningRecItem) {
        planRecType = 5
        todoTask.text = recItem.routine!
        if recItem.completed {
            todoBtn.isSelected = true
        } else {
            todoBtn.isSelected = false
        }
        todoBtn.transform = .identity
        eveningRecItem = recItem
        
        setupCellDetails()
    }
    
    func configureCell(recItem: AfternoonRecItem) {
        planRecType = 6
        todoTask.text = recItem.routine!
        if recItem.completed {
            todoBtn.isSelected = true
        } else {
            todoBtn.isSelected = false
        }
        todoBtn.transform = .identity
        afternoonRecItem = recItem
        
        setupCellDetails()
    }
    
    func configureCell(recItem: DeedsRecItem) {
        planRecType = 7
        todoTask.text = recItem.deedDetails!
        todoBtn.isSelected = true
        todoBtn.transform = .identity
        deedsRecItem = recItem
        
        setupCellDetails()
    }
    
    func setupCellDetails() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    @IBAction func todoSelected(_ sender: UIButton) {
        if planRecType == 1 {
            planRecItem.completed = !sender.isSelected
        } else if planRecType == 3 {
            goalPlanRecItem.completed = !sender.isSelected
        } else if planRecType == 4 {
            morningRecItem.completed = !sender.isSelected
        } else if planRecType == 5 {
            eveningRecItem.completed = !sender.isSelected
        } else if planRecType == 6 {
            afternoonRecItem.completed = !sender.isSelected
        } else {
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
}
