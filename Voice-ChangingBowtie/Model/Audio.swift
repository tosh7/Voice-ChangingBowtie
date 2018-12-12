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
    var audioPlayer: AVAudioPlayer! //今はこれで実装しているけど、後々、AVAudioEngineに変更する
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioUnitTimePitch: AVAudioUnitTimePitch!
    var audioUnitVarispeed: AVAudioUnitVarispeed!
    var audioUnitDelay: AVAudioUnitDelay!
    var audioUnitDistortion: AVAudioUnitDistortion!
    
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
    
    func setUpAudioPlayer() {
        let url = getAudioFilrUrl()
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            audioPlayer = sound
            audioPlayer.delegate = self as? AVAudioPlayerDelegate
            audioPlayer.prepareToPlay()
        } catch let error {
            print(error)
        }
    }
    
    func setUpAudioEngine() {
        audioEngine = AVAudioEngine()
        
        let url = getAudioFilrUrl()
        
        do {
            audioFile = try AVAudioFile(forReading: url)
            
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attach(audioPlayerNode)
            
            audioUnitTimePitch = AVAudioUnitTimePitch()
            audioUnitTimePitch.rate = 1
            audioEngine.attach(audioUnitTimePitch)
            
            audioEngine.connect(audioPlayerNode, to: audioUnitTimePitch, format: audioFile.processingFormat)
            
            audioEngine.prepare()
        } catch let error {
            print(error)
        }
    }
    
    func playSound(speed: Float, pitch: Float, echo: Bool, reverb: Bool) {
        audioEngine = AVAudioEngine()
        
        let url = getAudioFilrUrl()
        
        do {
            audioFile = try AVAudioFile(forReading: url)
            
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attach(audioPlayerNode)
            
            audioUnitTimePitch = AVAudioUnitTimePitch()
            audioUnitTimePitch.rate = speed
            audioUnitTimePitch.pitch = pitch
            audioEngine.attach(audioUnitTimePitch)
            
            connectAudioNodes(audioPlayerNode, audioUnitTimePitch, audioEngine.outputNode)
            
            audioPlayerNode.stop()
            audioPlayerNode.scheduleFile(audioFile, at: nil)
            
            try audioEngine.start()
            audioPlayerNode.play()
        } catch let error {
            print(error)
        }
    }
    
    func connectAudioNodes(_ nodes: AVAudioNode...) {
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
    private func getAudioFilrUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
        
        return audioUrl
    }
}
