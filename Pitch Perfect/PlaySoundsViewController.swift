//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Laura Fajardo on 8/29/15.
//  Copyright (c) 2015 rrubiorr81. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!;
    var receivedAudio: RecordedAudio!;
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var filePathUrl = NSURL.fileURLWithPath(filePath);
//            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil);
//        } else {
//        println("The file path is empty");
//        }
        println(receivedAudio.filePathUrl);
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil);
        audioPlayer.enableRate = true;
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000);
    }
    
    @IBAction func PlayChipmunk(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func PlaySnailed(sender: AnyObject) {
        self.playAtRate(0.5);
    }
    
    @IBAction func PlayRabbit(sender: AnyObject) {
        self.playAtRate(1.5);
    }

    @IBAction func stopPlay(sender: AnyObject) {
        audioPlayer.stop();
    }
    
    func playAtRate(numberRate: Float) {
        audioPlayer.stop();
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0;
        audioPlayer.rate = numberRate;
        audioPlayer.play();
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
