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
    
    @IBOutlet weak var speedSlider: UISlider! {
        didSet {
            speedSlider.minimumValue = 0.5
            speedSlider.maximumValue = 1.5
            speedSlider.setValue(1, animated: true)
            speedSlider.tintColor = .lightBlue
        }
    }
    @IBOutlet weak var pitchSlider: UISlider! {
        didSet {
            pitchSlider.minimumValue = -1000
            pitchSlider.maximumValue = 1000
            pitchSlider.setValue(0, animated: true)
            pitchSlider.tintColor = .lightBlue
        }
    }
    @IBOutlet weak var echoSwitch: UISwitch! {
        didSet {
            echoSwitch.isOn = false
            echoSwitch.onTintColor = .lightBlue
            echoSwitch.tintColor = .lightBlue
        }
    }
    @IBOutlet weak var reverbSwitch: UISwitch! {
        didSet {
            reverbSwitch.isOn = false
            reverbSwitch.onTintColor = .lightBlue
            reverbSwitch.tintColor = .lightBlue
        }
    }
    @IBOutlet weak var recordButton: UIButton! {
        didSet {
            recordButton.tintColor = .lightBlue
        }
    }
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.tintColor = .lightBlue
            playButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audio.setUpAudioRecorder()
    }
    
    @IBAction func record(_ sender: Any) {
        if !audio.audioRecorder.isRecording {
            audio.audioRecorder.record()
        } else {
            audio.audioRecorder.stop()
            playButton.isEnabled = true
        }
    }
    
    @IBAction func play(_ sender: Any) {
        audio.playSound(speed: speedSlider.value,
                        pitch: pitchSlider.value,
                        echo: echoSwitch.isOn,
                        reverb: reverbSwitch.isOn
        )
    }
}
