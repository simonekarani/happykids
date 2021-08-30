//
//  ViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/5/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        performSegue(withIdentifier: "gotohappykidsMain", sender: self)
    }
}

