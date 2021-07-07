//
//  EsteemMainTableViewCell.swift
//  happykids
//
//  Created by Simone Karani on 2/13/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import UIKit

class EsteemMainTableViewCell: UITableViewCell {

    @IBOutlet weak var esteemImg: UIImageView!
    
    @IBOutlet weak var esteemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
