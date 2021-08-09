//
//  HealthProgramMainCollectionViewController.swift
//  happykids
//
//  Created by Simone Karani on 7/5/21.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class HealthProgramMainCollectionViewController: UICollectionViewController, YTPlayerViewDelegate {

    let frontLabelArray = ["10 Steps", "Soda & Juice", "Vision Test",
                           "Hearing Test", "Dental Test",  "Brushing Song",
                           "Structure & Routine",  "Flipping Your Lid"]
    let frontImageArray = [
        UIImage(named: "10steps"),
        UIImage(named: "sodajuice"),
        UIImage(named: "visionTest"),
        UIImage(named: "hearingTest"),
        UIImage(named: "dentalTest"),
        UIImage(named: "brushingsong"),
        UIImage(named: "structure"),
        UIImage(named: "flippingLid")
    ]
    var tablefontSize: Int = 22
    @IBOutlet weak var ytPlayer: YTPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ytPlayer.delegate = self

        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize( width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/4)
        
        //        self.navigationController?.navigationBar.titleTextAttributes =
        //            [NSAttributedString.Key.foregroundColor: UIColor.red,
        //             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]
        
        print("frame=\(self.view.frame) , width=\(self.view.frame.width), height=\(self.view.frame.height)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if ytPlayer != nil {
            ytPlayer.stopVideo()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frontImageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frontCell", for: indexPath) as! MainCollectionViewCell
        
        cell.frontLabel.text = frontLabelArray[indexPath.item]
        cell.frontImage.image = frontImageArray[indexPath.item]
        if indexPath.row > 0 {
            cell.videoImage.image = UIImage(named: "ytube")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 4

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "goto10step", sender: self)
            
        case 1:
            ytPlayer.load(withVideoId: "qi4ndEBXWuc?rel=0")

        case 2:
            ytPlayer.load(withVideoId: "kGMQ5MYaH3M?rel=0")

        case 3:
            ytPlayer.load(withVideoId: "_QSHHR70lcQ?rel=0")

        case 4:
            ytPlayer.load(withVideoId: "vXg60WC0juw?rel=0")

        case 5:
            ytPlayer.load(withVideoId: "o-x1krVSnuY?rel=0")
            
        case 6:
            ytPlayer.load(withVideoId: "FseBfTX3cw8?rel=0")
            
        case 7:
            ytPlayer.load(withVideoId: "xemUpOKZjf4?rel=0")
            
        default:
            performSegue(withIdentifier: "goto10step", sender: self)
        }
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

    @IBAction func backFromUnwind(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}
