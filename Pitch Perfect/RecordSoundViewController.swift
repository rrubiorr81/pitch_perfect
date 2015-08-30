//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Laura Fajardo on 8/27/15.
//  Copyright (c) 2015 rrubiorr81. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!

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

        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
//        let currentDateTime = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "ddMMyyyy-HHmmss"
//        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        let recordingName = "my_audio.wav";
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
        
        
        
        playButton.enabled = false;
        recordingInProgress.hidden = false;
        stopButton.hidden = false;
        //TODO: record user's voice
        println("grabando voz");
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag)
        {
            recordedAudio = RecordedAudio();
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
        
            //move to the segue view...
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else{
            println("recording was not sucessfull")
            stopButton.hidden = true;
            playButton.enabled = true;
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //hide stop button
        stopButton.hidden = true;
    }

    
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true;
        playButton.enabled = true;
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
}

