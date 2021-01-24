//
//  ViewController.swift
//  recordAPPswift2
//
//  Created by 井関竜太郎 on 2021/01/21.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,AVAudioRecorderDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var recordingSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    var numberOfRecords = 0
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var recordButton: UIButton!
    
    var recording:Bool = false
    
    var isplaying:Bool = false
    
    // let numberCell = NumberCell()
    
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        recordButton.frame = CGRect(x: 176, y: 809, width: 75, height: 75)
        recordButton.layer.masksToBounds = true
        recordButton.layer.cornerRadius = 0
    }
    
    
    
    
    
    @IBAction func record(_ sender: Any){
        if audioRecorder == nil {
            numberOfRecords += 1
            // let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
             let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
    //        let filename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "「YYYY-MM-dd HH:mm:ss」")).m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            do {
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                recordButton.setTitle("", for: .normal)
                recordButton.frame = CGRect(x: 176, y: 809, width: 75, height: 75)
                recordButton.layer.masksToBounds = true
                recordButton.layer.cornerRadius = 35.0
                print("録音中")
            }
            catch {
                displayAlert(title: "Ups!", message: "Recording failed")
            }
        }else {
            audioRecorder.stop()
            audioRecorder = nil
            UserDefaults.standard.setValue(numberOfRecords, forKey: "myNumber")
            myTableView.reloadData()
            
            recordButton.setTitle("", for: .normal)
            recordButton.frame = CGRect(x: 176, y: 809, width: 75, height: 75)
            recordButton.layer.masksToBounds = true
            recordButton.layer.cornerRadius = 3
            print("録音停止")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = 120
        
        recordingSession = AVAudioSession.sharedInstance()
        if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print("ユーザーが許可しました。")
            }else{
                print("許可していません。")
            }
        }
    }
    
    
    
    
    
    
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecords
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //縦の大きさ
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //   numberOfRecords.remove(at: indexPath.row)
            
            
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isplaying == false {
            //audioをセットするところ
            print(indexPath.row)
        //let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
            
            let path =  getDirectory().appendingPathComponent("\(indexPath.row).m4a")
            
            do {
              audioPlayer = try AVAudioPlayer(contentsOf: path)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                isplaying = true
                
                // start.isHidden = true
            } catch {
                print("再生できないよ")
            }
        }else {
            audioPlayer.stop()
            isplaying = false
        }
    }
    
    
    
    
    
    func play() {
        let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filename)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        } catch {
            print("playback faild")
        }
        
    }
    
    
    func audioStop() {
        audioPlayer.stop()
    }
    
    func audioPause() {
        audioPlayer.pause()
    }
    
    
    
    
}

extension Date {
    func toString( dateFormat format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
