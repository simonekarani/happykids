//
//  GoalPlanTableViewCell.swift
//  happykids
//
//  Created by Simone Karani on 3/5/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import UIKit

class GoalPlanTableViewCell: UITableViewCell {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
    }
    
    func configureCell(section: Int, lblText: String) {
        yearLabel.font = yearLabel.font.withSize(18)
        addBtn.tag = 2000 + section
        yearLabel.text = lblText
        setupCellDetails()
    }
    
    func setupCellDetails() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
