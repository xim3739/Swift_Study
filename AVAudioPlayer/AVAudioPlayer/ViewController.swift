//
//  ViewController.swift
//  AVAudioPlayer
//
//  Created by 심재현 on 08/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    let STATUS_PLAY = 0
    let STATUS_PAUSE = 1
    let STATUS_STOP = 2
    let STATUS_RECORD = 3
    let MAX_VOLUME: Float = 10.0
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector:Selector = #selector(ViewController.updateRecordTime)
    
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    var progressTimer: Timer!
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecordTime: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            initRecord()
        }
    }
    
    func changeImage(status: Int) {
        switch status {
        case STATUS_PLAY:
            imageView.image = UIImage(named: "pic1.png")
        case STATUS_PAUSE:
            imageView.image = UIImage(named: "pic2.png")
        case STATUS_STOP:
            imageView.image = UIImage(named: "pic3.png")
        case STATUS_RECORD:
            imageView.image = UIImage(named: "pic4.png")
        default:
            print("Error")
        }
    }
    
    func selectAudioFile() {
        if !isRecordMode {
            audioFile = Bundle.main.url(forResource: "sky_of_night", withExtension: "mp3")
        } else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    func initRecord() {
        let recordSettings = [AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] as [String: Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        
        sliderVolume.value = 1.0
        audioPlayer.volume = sliderVolume.value
        lblEndTime.text = convertNSTimerInterval12String(0)
        lblCurrentTime.text = convertNSTimerInterval12String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        sliderVolume.maximumValue = MAX_VOLUME
        sliderVolume.value = 1.0
        progressBar.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = sliderVolume.value
        lblEndTime.text = convertNSTimerInterval12String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimerInterval12String(0)
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimerInterval12String(_ time: TimeInterval) -> String{
        let min = Int(time / 60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        changeImage(status: STATUS_PLAY)
        
    }
    @IBAction func btnPause(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
        changeImage(status: STATUS_PAUSE)
    }
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimerInterval12String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
        changeImage(status: STATUS_STOP)
    }
    @IBAction func slChangVolume(_ sender: UISlider) {
        audioPlayer.volume = sliderVolume.value
    }
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimerInterval12String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimerInterval12String(0)
        }
        selectAudioFile()
        
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    @IBAction func btnRecord(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
            audioRecorder.record()
            sender.setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
            
            changeImage(status: STATUS_RECORD)
        } else {
            audioRecorder.stop()
            progressTimer.invalidate()
            sender.setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
            
            changeImage(status: STATUS_STOP)
        }
    }
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimerInterval12String(audioPlayer.currentTime)
        progressBar.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
    
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimerInterval12String(audioRecorder.currentTime)
        
    }
}

