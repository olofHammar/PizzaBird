//
//  PlaySound.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-05.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String, repeatNr: Int, volume: Float) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = repeatNr
            audioPlayer?.volume = volume
            audioPlayer?.play()
            
        } catch {
            print("ERROR: Couldn't find and play the sound.")
        }
    }
    
}
