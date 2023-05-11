//
//  SettingsView.swift
//  Climb
//
//  Created by Sandra Smothers on 5/11/23.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private let feedback = UINotificationFeedbackGenerator()

    private init() {}

    func trigger(_ notificaiton: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notificaiton)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
