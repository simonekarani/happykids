//
//  HSRecDetailTableViewCell.swift
//  happykids
//
//  Created by Simone Karani on 12/25/20.
//  Copyright © 2020 simonekarani. All rights reserved.
//

import UIKit

class RecDetailTableViewCell: UITableViewCell {
    
    weak var cellDelegate: GrowingCellProtocol?

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailDescription: UITextView!
    @IBOutlet weak var gradeLabel: UILabel!
    
    var inputViewScreen: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailDescription.delegate = (self as UITextViewDelegate)
        detailDescription.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInputView(inputScreen: String) {
        inputViewScreen = inputScreen
    }
    
    func setupCellDetails() {
        selectionStyle = .none
        
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}

protocol GrowingCellProtocol: class {
    func updateHeightOfRow(_ cell: RecDetailTableViewCell, _ textView: UITextView)
}

extension RecDetailTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = cellDelegate {
            deletate.updateHeightOfRow(self, textView)
        }
    }
}
