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
            speedSlider.tintColor = UIColor.lightBlue
        }
    }
    @IBOutlet weak var pitchSlider: UISlider! {
        didSet {
            pitchSlider.minimumValue = -1000
            pitchSlider.maximumValue = 1000
            pitchSlider.setValue(0, animated: true)
            pitchSlider.tintColor = UIColor.lightBlue
        }
    }
    @IBOutlet weak var echoSwitch: UISwitch! {
        didSet {
            echoSwitch.isOn = false
            echoSwitch.onTintColor = UIColor.lightBlue
            echoSwitch.tintColor = UIColor.lightBlue
        }
    }
    @IBOutlet weak var reverbSwitch: UISwitch! {
        didSet {
            reverbSwitch.isOn = false
            reverbSwitch.onTintColor = UIColor.lightBlue
            reverbSwitch.tintColor = UIColor.lightBlue
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
