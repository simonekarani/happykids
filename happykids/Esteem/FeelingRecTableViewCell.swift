//
//  FeelingRecTableViewCell.swift
//  happykids
//
//  Created by Simone Karani on 2/16/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import UIKit
import Foundation

class FeelingRecTableViewCell: UITableViewCell {

    @IBOutlet weak var feelingTitle: UILabel!
    @IBOutlet weak var feelingDate: UILabel!
    @IBOutlet weak var feelingDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(recItem: EsteemRecItem, count: Int) {
        let index = recItem.feelingType!.index(recItem.feelingType!.startIndex, offsetBy: 1)
        let fType:String = String(recItem.feelingType!.prefix(upTo: index))
        feelingTitle.text = fType + ":" + recItem.msgTitle!
        feelingDate.text = recItem.date
        feelingDetails.text = recItem.message
        
        setupCellDetails()
    }
    
    func setupCellDetails() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
