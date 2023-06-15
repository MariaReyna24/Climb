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
            .toggleStyle(HapticsToggleStyle(isSoundEnabled: isSoundEnabled))
            .listRowBackground(Color("whiteOpacity"))
    }
}

struct HapticsToggleStyle: ToggleStyle {
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    var isSoundEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .frame(height: 75)
                .foregroundColor(Color.white)
                .font(.custom("RoundsBlack", size: 27))
            
            Spacer()
            
            Button(action: {
                configuration.isOn.toggle()
                if isSoundEnabled {
                    SoundManager.instance.playSound(sound: .click)
                }
            }) {
                ZStack {
                    Image(systemName: isHapticsEnabled ? "hand.point.up.left.fill" : "hand.point.up.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(configuration.isOn ? Color.green : Color.gray)
                        .frame(width: 50, height: 50)
                )
            }
            .frame(width: 50, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color("whiteOpacity"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color("WhiteDM"), lineWidth: 5)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            )
            .shadow(color: Color("pauseColor"), radius: 5, x: 0, y: 0)
            .padding(0.5)
            .controlSize(.large)
        }
    }
}

private extension SettingsView {
    var sound: some View {
        Toggle("Enable Sound", isOn: $isSoundEnabled)
            .toggleStyle(SoundToggleStyle(isHapticsEnabled: isHapticsEnabled))
            .listRowBackground(Color("whiteOpacity"))
    }
}

struct SoundToggleStyle: ToggleStyle {
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    var isHapticsEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .frame(height: 75)
                .foregroundColor(Color.white)
                .font(.custom("RoundsBlack", size: 25))
            
            Spacer()
            
            Button(action: {
                configuration.isOn.toggle()
                if isHapticsEnabled {
                    heavyHaptic()
                }
                if isSoundEnabled {
                    SoundManager.instance.playSound(sound: .click)
                }
            }) {
                ZStack {
                    Image(systemName: isSoundEnabled ? "speaker.wave.3.fill" : "speaker.slash.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(configuration.isOn ? Color.green : Color.gray)
                        .frame(width: 50, height: 50)
                )
            }
            .frame(width: 50, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color("whiteOpacity"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color("WhiteDM"), lineWidth: 5)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            )
            .shadow(color: Color("pauseColor"), radius: 5, x: 0, y: 0)
            .padding(0.5)
            .controlSize(.large)
        }
    }
}




struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(scene: diffViews(), game: Math())
    }
}
