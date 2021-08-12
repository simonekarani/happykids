//
//  DentalFirstViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/18/21.
//

import UIKit
import youtube_ios_player_helper

class DentalFirstViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var emailDentalLabel: UILabel!
    @IBOutlet weak var phoneDentalLabel: UILabel!
    
    @IBOutlet weak var ytPlayer: YTPlayerView!
    @IBOutlet weak var dentalVideoButton: UIButton!
    @IBOutlet weak var ytubeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ytPlayer.delegate = self

        emailDentalLabel.isUserInteractionEnabled = true
        phoneDentalLabel.isUserInteractionEnabled = true
        setupLabelInteractions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ytPlayer.stopVideo()
    }
    
    func setupLabelInteractions() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(emailDentalClicked(_:)))
        gesture1.numberOfTapsRequired = 1
        emailDentalLabel.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(callDentalClicked(_:)))
        gesture2.numberOfTapsRequired = 1
        phoneDentalLabel.addGestureRecognizer(gesture2)
    }
    
    @objc func emailDentalClicked(_ sender: Any) {
        /*if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://14085645114"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }*/
    }

    @objc func callDentalClicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://14085645114"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }

    @IBAction func videoButtonClicked(_ sender: Any) {
        ytPlayer.load(withVideoId: "vXg60WC0juw?rel=0")
    }
    
    @IBAction func ytubeButtonClicked(_ sender: Any) {
        ytPlayer.load(withVideoId: "vXg60WC0juw?rel=0")
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        ytPlayer.playVideo()
    }

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState)
    {
        switch state {
        case YTPlayerState.ended:
            ytPlayer.stopVideo()
            ytPlayer.removeWebView()
            break;
        default:
            break;
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
