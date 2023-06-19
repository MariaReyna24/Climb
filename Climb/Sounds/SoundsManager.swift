//
//  SoundsManager.swift
//  Climb
//
//  Created by Sandra Smothers on 5/19/23.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {

        case chime
        case fail
        case wrong
        case win
        case click
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}


