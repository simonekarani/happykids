//
//  SmileFirstViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/18/21.
//

import UIKit

class SmileFirstViewController: UIViewController {

    @IBOutlet weak var emailSmileLabel: UILabel!
    @IBOutlet weak var callSmileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailSmileLabel.isUserInteractionEnabled = true
        callSmileLabel.isUserInteractionEnabled = true
        setupLabelInteractions()
    }
    

    func setupLabelInteractions() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(emailSmileClicked(_:)))
        gesture1.numberOfTapsRequired = 1
        emailSmileLabel.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(callSmileClicked(_:)))
        gesture2.numberOfTapsRequired = 1
        callSmileLabel.addGestureRecognizer(gesture2)
    }
    
    @objc func emailSmileClicked(_ sender: Any) {
        /*if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://14085645114"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }*/
    }

    @objc func callSmileClicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://14085645114"),
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
