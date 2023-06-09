//
//  SettingsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/11/23.
//


import SwiftUI
import AVKit
struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    var body: some View {
        
        ZStack {
            PlainBackground()
                .offset(y:-50)
                
                    Image("Settings")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
                .offset(y: colorScheme == .light ? -0 : 75)
                .offset(x:23, y:-400)
                .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
            
            
            Button {
                if game.isPaused == true {
                    scene.state = .pauseMenu
                } else {
                    scene.state = .mainmenu
                }
                
                heavyHaptic()
            }label: {
                Image("BackButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height:200)
                //.offset( y:40)
                    .offset(y: colorScheme == .light ? 50 : 13)
                    .offset(x: colorScheme == .light ? -3 : -5)
                    .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
            }
            
            
            .offset(x:-155,y:-415)
            VStack {
                
                
                Form {
                    haptics
                    sound
                }.scrollContentBackground(.hidden)
                    .offset(y:125)
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
