//
//  HearingFirstViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/18/21.
//

import UIKit
import youtube_ios_player_helper

class HearingFirstViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var emailHearingLabel: UILabel!
    @IBOutlet weak var phoneHearingLabel: UILabel!
    
    @IBOutlet weak var ytPlayer: YTPlayerView!
    @IBOutlet weak var hearingTestButton: UIButton!
    @IBOutlet weak var ytButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ytPlayer.delegate = self

        emailHearingLabel.isUserInteractionEnabled = true
        phoneHearingLabel.isUserInteractionEnabled = true
        setupLabelInteractions()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ytPlayer.stopVideo()
    }
    
    func setupLabelInteractions() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(emailHearingClicked(_:)))
        gesture1.numberOfTapsRequired = 1
        emailHearingLabel.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(callHearingClicked(_:)))
        gesture2.numberOfTapsRequired = 1
        phoneHearingLabel.addGestureRecognizer(gesture2)
    }
    
    @objc func emailHearingClicked(_ sender: Any) {
        /*if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://14085645114"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }*/
    }

    @objc func callHearingClicked(_ sender: Any) {
        if #available(iOS 10.0, *) {
            guard let url = URL(string: "tel://14085645114"),
                UIApplication.shared.canOpenURL(url) else {
                    return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }

    @IBAction func hearingTestClicked(_ sender: Any) {
        ytPlayer.load(withVideoId: "_QSHHR70lcQ?rel=0")
    }
    
    @IBAction func ytButtonClicked(_ sender: Any) {
        ytPlayer.load(withVideoId: "_QSHHR70lcQ?rel=0")
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
