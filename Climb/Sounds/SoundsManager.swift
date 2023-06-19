import SwiftUI
import AVKit
import AVFoundation

class SoundManager: ObservableObject {
    var player: AVAudioPlayer?
    static let instance = SoundManager()
    private var players: [SoundOption: AVAudioPlayer] = [:]
    var volume: Float = 1.0 // Default volume
    
    enum SoundOption: String, CaseIterable {
        case chime
        case fail
        case wrong
        case win
        case click
    }
    
    init() {
        preloadSounds()
    }
    
    private func preloadSounds() {
        for sound in SoundOption.allCases {
            guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { continue }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                players[sound] = player
            } catch let error {
                print("Error preloading sound '\(sound.rawValue)': \(error.localizedDescription)")
            }
        }
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        let isSilentMode = isDeviceInSilentMode()
        if isSilentMode {
            return // Exit early if in silent mode
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            adjustVolume(for: sound)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    private func adjustVolume(for sound: SoundOption) {
        if sound == .click {
            player?.volume = volume * 0.25 // Adjust volume for click sound
        } else {
            player?.volume = volume // Use default volume for other sounds
        }
    }
    
    private func isDeviceInSilentMode() -> Bool {
        let currentCategory = AVAudioSession.sharedInstance().category
        return currentCategory == .soloAmbient
    }
}


