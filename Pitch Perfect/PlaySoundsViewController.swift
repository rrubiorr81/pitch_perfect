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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        audioPlayer.currentTime = 0.0;
        audioPlayer.rate = numberRate;
        audioPlayer.play();
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
