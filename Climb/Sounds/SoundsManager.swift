import SwiftUI
import AVKit
import AVFoundation

class SoundManager: ObservableObject {
    static let instance = SoundManager()
    private var players: [SoundOption: AVAudioPlayer] = [:]
    
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
        guard let player = players[sound] else { return }
        
        let isSilentMode = isDeviceInSilentMode()
        if isSilentMode {
            return // Exit early if in silent mode
        }
        
        player.currentTime = 0
        player.play()
    }
    
    private func isDeviceInSilentMode() -> Bool {
        let currentCategory = AVAudioSession.sharedInstance().category
        return currentCategory == .soloAmbient
    }
}
