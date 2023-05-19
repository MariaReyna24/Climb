//
//  SettingsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/11/23.
//


import SwiftUI
import AVKit

struct SettingsView: View {
    @ObservedObject var scene: diffViews
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
  
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                Button("Back"){
                    scene.state = .mainmenu
                    heavyHaptic()
                }
                .font(.title2)
                .foregroundColor(.red)
                Form {
                    haptics
                    sound
                }
                .navigationBarTitle("Settings")
            }
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

private extension SettingsView {
    var sound: some View {
        Toggle("Enable Sound", isOn: $isSoundEnabled)
   }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(scene: diffViews())
    }
}
