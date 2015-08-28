//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Laura Fajardo on 8/27/15.
//  Copyright (c) 2015 rrubiorr81. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {

        playButton.enabled = false;
        recordingInProgress.hidden = false;
        stopButton.hidden = false;
        //TODO: record user's voice
        println("grabando voz");
    }
    
    override func viewWillAppear(animated: Bool) {
        //hide stop button
        stopButton.hidden = true;
    }

    
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true;
        playButton.enabled = true;
    }
    
}

