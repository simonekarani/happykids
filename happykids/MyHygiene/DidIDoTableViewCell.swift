//
//  DidIDoTableViewCell.swift
//  happykids
//
//  Created by Simone Karani on 7/10/21.
//

import UIKit

class DidIDoTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var didImg: UIImageView!
    @IBOutlet weak var didText: UITextField!
    
    var isCheckSelected:Bool? = false
    
    // Inside our custom cell
    weak var delegate: MyDayTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkBtnSelected(_ sender: Any) {
        isCheckSelected = true
        //delegate?.toggleCheckmark(for: self)
        let checkImg = UIImage(named: "checkmark")
        checkBtn.setImage(checkImg , for: UIControl.State.normal)
        delegate?.updateTableView()
    }
}
