//
//  Step10ViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/17/21.
//

import UIKit
import youtube_ios_player_helper

class Step10ViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var email10step: UILabel!
    @IBOutlet weak var phone10step: UILabel!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var ytubeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email10step.isUserInteractionEnabled = true
        phone10step.isUserInteractionEnabled = true
        
        ytPlayer.delegate = self

        setupLabelInteractions()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Workshop",
            style: .plain,
            target: self,
            action: #selector(workshopTapped)
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ytPlayer.stopVideo()
    }
    
    @IBAction func workshopTapped(_ sender: Any) {
        performSegue(withIdentifier: "gotoWorkshop", sender: self)
    }
    
    func setupLabelInteractions() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(callEmail10Clicked(_:)))
        gesture1.numberOfTapsRequired = 1
        email10step.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(callPhone10Clicked(_:)))
        gesture2.numberOfTapsRequired = 1
        phone10step.addGestureRecognizer(gesture2)
    }
    
    @objc func callEmail10Clicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://8553446347"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }

    @objc func callPhone10Clicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://8553446347"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }

    @IBAction func videoClicked(_ sender: Any) {
        ytPlayer.load(withVideoId: "qi4ndEBXWuc")
    }
    
    
    @IBAction func ytubeClicked(_ sender: Any) {
        ytPlayer.load(withVideoId: "qi4ndEBXWuc")
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        ytPlayer.playVideo()
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
