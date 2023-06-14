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
        NavigationStack{
            GeometryReader { geometry in
                ZStack {
                    PlainBackground()
                        .ignoresSafeArea(.all)
                    SettingsLogo()
                        .offset(y: -0.30 * geometry.size.height)
                        .offset(x: 0.06 * geometry.size.height)
                    
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                               
                                    Button {
                                        if game.isPaused == true{
                                            scene.state = .pauseMenu
                                        } else {
                                            scene.state = .mainmenu
                                        }
                                        heavyHaptic()
                                        if isSoundEnabled {
                                            SoundManager.instance.playSound(sound: .click)
                                        }
                                        
                                    } label: {
                                        Image("BackButton")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 175, height: 175)
                                            .offset(x: -55, y: 35)
                                            .offset(y: colorScheme == .light ? 0 : -30)
                                            .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                                            .transaction { transaction in
                                                transaction.animation = nil
                                            }
                                
                                }
                            }
                        }
                }
            }
            
            
            GeometryReader { geometry in
                VStack {
                    
                    
                    Form {
                        haptics
                        sound
                    }.scrollContentBackground(.hidden)
                        .offset(y: -0.80 * geometry.size.height)
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
