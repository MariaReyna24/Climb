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
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    var body: some View {
        NavigationStack{
            ZStack {
                PlainBackground()
                    .offset(y:-50)
                VStack {
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.custom("RoundsBlack", size: 40))
                    .frame(maxWidth: .infinity, alignment: .top)
                    Form {
                        haptics
                        sound
                    }.scrollContentBackground(.hidden)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if game.isPaused == true{
                            scene.state = .pauseMenu
                        }else {
                            scene.state = .mainmenu
                        }
                        heavyHaptic()
                    }label: {
                        Label("Back", systemImage: "chevron.backward")
                    }
                    .font(.title2)
                    .foregroundColor(Color("myColor"))
                }
            }
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
            .font(.custom("RoundsBlack", size: 20))
            .listRowBackground(Color("whiteOpacity"))
            .foregroundColor(Color.white)
        
    }
}

private extension SettingsView {
    var sound: some View {
        Toggle("Enable Sound", isOn: $isSoundEnabled)
            .font(.custom("RoundsBlack", size: 20))
            .listRowBackground(Color("whiteOpacity"))
            .foregroundColor(Color.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(scene: diffViews(), game: Math())
    }
}
