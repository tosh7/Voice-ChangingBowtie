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
    
    var audio = Audio()
    var isRecording = false
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audio.setUpAudioRecorder()
    }
    
    @IBAction func record(_ sender: Any) {
        if !isRecording {
            isRecording = true
            audio.audioRecorder.record()
        } else {
            isRecording = false
            audio.audioRecorder.stop()
        }
    }
    
    @IBAction func play(_ sender: Any) {
        if !isPlaying {
            isPlaying = true
            audio.playSound()
        } else {
            isPlaying = false
            audio.audioPlayer.stop()
        }
    }
}
