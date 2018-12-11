//
//  AudioChageModel.swift
//  Voice-ChangingBowtie
//
//  Created by Satoshi Komatsu on 2018/12/11.
//  Copyright © 2018 Satoshi Komatsu. All rights reserved.
//

import UIKit
import AVFoundation

final class Audio {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    init() {}
    
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
            audioRecorder.delegate = self as? AVAudioRecorderDelegate
        } catch let error {
            print(error)
        }
    }
    
    func playSound() {
        let url = getAudioFilrUrl()
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            audioPlayer = sound
            
            audioPlayer.delegate = self as? AVAudioPlayerDelegate
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print(error)
        }
    }
    
    private func getAudioFilrUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
        
        return audioUrl
    }
}
