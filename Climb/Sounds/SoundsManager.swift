import SwiftUI
import AVKit

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
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = sound == .click ? volume * 0.25 : volume
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
