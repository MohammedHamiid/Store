//
//  VoiceRecordVC.swift
//  Store
//
//  Created by Mohamed on 8/21/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage


protocol SendPathRecord {
    func path (url:String)
}

class VoiceRecordVC: UIViewController , AVAudioPlayerDelegate , AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordBTN: UIButton!
    @IBOutlet weak var playBTN: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    
    var fileName: String = "audioFile.m4a"
    
    var delegate : SendPathRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        playBTN.isEnabled = false
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey : AVAudioQuality.min.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.2] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting )
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBTN.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBTN.isEnabled = true
        playBTN.setTitle("Play", for: .normal)
    }
    
    @IBAction func popButton(_ sender: Any) {
        popVC()
    }
    
    func sendPathBack (url : String){
        delegate?.path(url: url)
    }
    
    @IBAction func recordAct(_ sender: Any) {
        
        if recordBTN.titleLabel?.text == "Record" {
            soundRecorder.record()
            recordBTN.setTitle("Stop", for: .normal)
            playBTN.isEnabled = false
        } else {
            soundRecorder.stop()
            recordBTN.setTitle("Record", for: .normal)
            playBTN.isEnabled = false
        }
    }
    
    @IBAction func playAct(_ sender: Any) {
        
        if playBTN.titleLabel?.text == "Play" {
            playBTN.setTitle("Stop", for: .normal)
            recordBTN.isEnabled = false
            setupPlayer()
            soundPlayer.play()
        } else {
            soundPlayer.stop()
            playBTN.setTitle("Play", for: .normal)
            recordBTN.isEnabled = false
        }
    }
    
    
    var pathOnFireBase = "noPath"
    
    @IBAction func sendRecordToFirebase(_ sender: Any) {
        let n1 = Int.random(in: 0 ... 10000)
        let n2 = Int.random(in: 0 ... 100000)
        let n3 = Int.random(in: 0 ... 1000000)
        
        uploadRecord(random1: n1, random2: n2, random3: n3)
    }
    
    
    
    func uploadRecord (random1 : Int , random2 : Int , random3 : Int) {
        
        setupPlayer()
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        let voiceName = "voice\(random1)\(random2)\(random3)"
        
        let riversRef = Storage.storage().reference().child("records/\(voiceName).wav")
        riversRef.putFile(from: audioFilename, metadata: nil) { metadata, error in
            
            if error != nil {
                
            }else{
                self.presentAlertWith(msg: "Upload Success ☑️") {}
                riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }

                    self.pathOnFireBase = "\(downloadURL)"
                    print("pathOnFireBase == \(self.pathOnFireBase)")
                    self.sendPathBack(url: "\(downloadURL)")
                }
            }
        }
    }
    
}
