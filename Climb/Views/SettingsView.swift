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
                        .offset(x: 0.08 * geometry.size.height)
                    
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
                VStack(spacing:30) {
                    
                    
                        haptics
                        sound
                        
                    }.scrollContentBackground(.hidden)
                        .offset(y: -0.70 * geometry.size.height)
                        .offset(x: 0.07 * geometry.size.height)
                }
            }
            
        }
        
    }



private extension SettingsView {
    var haptics: some View {
        HStack {
            Text("Haptics")
                .font(.custom("RoundsBlack", size: 35))
                .foregroundColor(Color("textColor"))
                .padding()
            
            Spacer()
            
            Button(action: {
                isHapticsEnabled.toggle()
                if isSoundEnabled {
                    SoundManager.instance.playSound(sound: .click)
                }
            }) {
                Image(systemName: isHapticsEnabled ? "hand.point.up.left.fill" : "hand.point.up.left")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(isHapticsEnabled ? Color.green : Color.gray)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("WhiteDM"), lineWidth: 4)
                    )
                    .shadow(
                        color: Color.black.opacity(0.5),
                        radius: 4,
                        x: 0,
                        y: 0
                    )
                    .shadow(color: Color("WhiteDM"), radius: 6, x: 0, y: 0)
            }
        }
        .padding(35)
        .frame(width:340)
        .frame(height: 110)
        .background(Color("pauseColor"))
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color("WhiteDM"), lineWidth: 6)
        )
        .shadow(
            color: Color.black.opacity(0.5),
            radius: 6,
            x: 0,
            y: 0
        )
    }
}

private extension SettingsView {
    var sound: some View {
        HStack {
            Text("Sound")
                .font(.custom("RoundsBlack", size: 38))
                .foregroundColor(Color("textColor"))
                .padding(23)
                .offset(x:-5)
            
            Spacer()
            
            Button(action: {
                isSoundEnabled.toggle()
                if isSoundEnabled {
                    SoundManager.instance.playSound(sound: .click)
                }
            }) {
                Image(systemName: isSoundEnabled ? "speaker.wave.3.fill" : "speaker.slash.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(isSoundEnabled ? Color.green : Color.gray)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("WhiteDM"), lineWidth: 4)
                    )
                    .shadow(
                        color: Color.black.opacity(0.5),
                        radius: 4,
                        x: 0,
                        y: 0
                    )
                    .shadow(color: Color("WhiteDM"), radius: 6, x: 0, y: 0)
            }
        }
        .padding(35)
        .frame(width:340)
        .frame(height: 110)
        .background(Color("pauseColor"))
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color("WhiteDM"), lineWidth: 6)
        )
        .shadow(
            color: Color.black.opacity(0.5),
            radius: 6,
            x: 0,
            y: 0
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(scene: diffViews(), game: Math())
    }
}
