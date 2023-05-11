//
//  SettingsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/11/23.
//


import SwiftUI

struct SettingsView: View {
    @ObservedObject var scene: diffViews
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
  
    var body: some View {
        NavigationStack {
            Button("Back"){
                scene.state = .mainmenu
            }
            .font(.title2)
            .foregroundColor(.red)
            Form {
                haptics
            }
            .navigationBarTitle("Settings")
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(scene: diffViews())
    }
}
