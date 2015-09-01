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
    
    let TAPTORECORD = "Tap to Record"
    let RECORDING = "recording"
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "stopRecording"){
            //playSoundsVC is apparently a pointer to the PlaySoundsViewController view.
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
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
//        recordingInProgress.hidden = false;
        recordingInProgress.text = RECORDING
        stopButton.hidden = false;
        //TODO: record user's voice
        println("grabando voz");
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag)
        {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!);
//            recordedAudio.filePathUrl = recorder.url
//            recordedAudio.title = recorder.url.lastPathComponent
        
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
        recordingInProgress.text = TAPTORECORD
    }

    
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.text = TAPTORECORD	
        playButton.enabled = true;
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
}

