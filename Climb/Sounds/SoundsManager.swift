import SwiftUI
import AVKit
import AVFoundation

class SoundManager: ObservableObject {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    var volume: Float = 1.0 // Default volume
    
    enum SoundOption: String {
        case chime
        case fail
        case wrong
        case win
        case click
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }
        do {
            let isSilentMode = isDeviceInSilentMode()
            if isSilentMode {
                return // Exit early if in silent mode
            }
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = sound == .click ? volume * 0.25 : volume
            player?.play()
            
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [])
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
    private func isDeviceInSilentMode() -> Bool {
        let currentCategory = AVAudioSession.sharedInstance().category
        let currentOptions = AVAudioSession.sharedInstance().categoryOptions
        
        return currentCategory == .ambient && currentOptions.contains(.mixWithOthers)
    }
}
