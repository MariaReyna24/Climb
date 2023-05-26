import Foundation
import UIKit

fileprivate final class HapticsManager {
static let shared = HapticsManager()

private let feedback = UINotificationFeedbackGenerator()
private let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)

private init() {}

func triggerImpact() {
    impactFeedback.impactOccurred()
}

func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    feedback.notificationOccurred(notification)
}
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
HapticsManager.shared.trigger(notification)
}
}

func heavyHaptic() {
if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
HapticsManager.shared.triggerImpact()
}
}

