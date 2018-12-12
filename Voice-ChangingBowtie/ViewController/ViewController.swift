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
    
    @IBOutlet weak var speedSlider: UISlider! {
        didSet {
            speedSlider.minimumValue = 0
            speedSlider.maximumValue = 2
            speedSlider.setValue(1, animated: true)
            speedSlider.tintColor = UIColor.green
        }
    }
    @IBOutlet weak var pitchSlider: UISlider! {
        didSet {
            pitchSlider.minimumValue = -1000
            pitchSlider.maximumValue = 1000
            pitchSlider.setValue(0, animated: true)
            pitchSlider.tintColor = UIColor.green
        }
    }
    @IBOutlet weak var echoSwitch: UISwitch! {
        didSet {
            echoSwitch.isOn = false
        }
    }
    @IBOutlet weak var reverbSwitch: UISwitch! {
        didSet {
            reverbSwitch.isOn = false
        }
    }
    
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
            audio.playSound(speed: speedSlider.value,
                            pitch: pitchSlider.value,
                            echo: echoSwitch.isOn,
                            reverb: reverbSwitch.isOn)
        } else {
            isPlaying = false
            audio.audioPlayer.stop()
        }
    }
}
