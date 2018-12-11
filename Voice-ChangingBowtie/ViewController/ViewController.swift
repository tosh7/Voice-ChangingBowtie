//
//  ViewController.swift
//  Voice-ChangingBowtie
//
//  Created by Satoshi Komatsu on 2018/12/11.
//  Copyright © 2018 Satoshi Komatsu. All rights reserved.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAudioRecorder()
    }
    
    @IBAction func record(_ sender: Any) {
        if !isRecording {
            isRecording = true
            audioRecorder.record()
        } else {
            isRecording = false
            audioRecorder.stop()
        }
    }
    
    @IBAction func play(_ sender: Any) {
        if !isPlaying {
            isPlaying = true
            playSound()
        } else {
            isPlaying = false
            audioPlayer.stop()
        }
    }
}

extension ViewController: AVAudioRecorderDelegate {
    func setUpAudioRecorder() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: getAudioFilrUrl(), settings: settings)
            audioRecorder.delegate = self
        } catch let error {
            print(error)
        }
    }
}

extension ViewController: AVAudioPlayerDelegate {
    func playSound() {
        let url = getAudioFilrUrl()
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            audioPlayer = sound
            
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print(error)
        }
    }
}

extension ViewController {
    func getAudioFilrUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
        
        return audioUrl
    }
}
