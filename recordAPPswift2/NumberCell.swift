//
//  NumberCell.swift
//  recordAPPswift2
//
//  Created by 井関竜太郎 on 2021/01/22.
//

//再生できるために、違いファイルから読み読めるようにする。
///cellの大きさを変える？->できた！
///sliderの追加→できた！

//スライダーをできるようにする。
//再生時間の取得
//削除できるものを追加する。

//おざわさんの話を聞く。
//履歴書を書く
//自己分析をする。



import Foundation
import UIKit
import AVFoundation

class NumberCell: UITableViewCell {
    
    let viewController = ViewController()
    var audioSwich:Bool = false
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    
    var audioPlayer:AVAudioPlayer!
    
    var timer: Timer!
    

    
   
    
    
    
    @IBAction func back(_ sender: Any) {
        // viewController.audioPlayer.currentTime -= 10
        print("back")
    }
    
    
    @IBAction func forward(_ sender: Any) {
        //  viewController.audioPlayer.currentTime += 10
        print("forward")
        
    }
    
    @IBAction func audioStart(_ sender: Any) {
      //  viewController.play()
    
        
        start.isHidden = true
        stop.isHidden = false
        print("再生")
        
    }
    
    @IBAction func audioStop(_ sender: Any) {
         viewController.audioStop()
        start.isHidden = false
        stop.isHidden = true
        print("ストップ")
    }
    
    
    @IBAction func slider(_ sender: UISlider) {
        
    }
    
}
