//
//  Pause Menu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import UIKit
import Foundation

struct Pause_menu: View {
    @ObservedObject var scene: diffViews
    @Environment(\.dismiss) var dismiss
    @ObservedObject var game : Math
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    @State private var isResumeButtonPressed = false
    @State private var isSettingsButtonPressed = false
    @State private var isMainMenuButtonPressed = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GameBackground()
                    .ignoresSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 7)
                
                VStack (spacing: 20){
                    Text("Current score: \(game.score)")
                        .font(.custom("RoundsBlack", size: 25))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    //  .offset(y:-25)
                    
                    Button(action: {
                        withAnimation{
                            dismiss()
                            game.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            heavyHaptic()
                            game.isPaused = false
                            isResumeButtonPressed = true
                            if isSoundEnabled {
                                SoundManager.instance.playSound(sound: .click)
                            }
                        }
                        heavyHaptic()
                    }) {
                        Text("Resume")
                            .font(.custom("RoundsBlack", size: 25))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 255, height: 80) // Adjusted width
                            .background(Color("pauseColor"))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                            )
                            .shadow(
                                color: Color.black.opacity(0.5),
                                radius: 6,
                                x: 0,
                                y: 0
                            )
                    }
                    
//                    .scaleEffect(isResumeButtonPressed ? 0.0 : 1.0)
//                    .buttonStyle(CustomButtonStyle())
//                    .onTapGesture {
//                        withTransaction(Transaction(animation: nil)) {
////                            scene.state = .settings
//                            isResumeButtonPressed = true
//                        }
//                        heavyHaptic()
//                    }
                    
//                    Button(action: {
//                        withAnimation{
//                            scene.state = .settings
//                            heavyHaptic()
//                            isSettingsButtonPressed = true
//                            if isSoundEnabled {
//                                SoundManager.instance.playSound(sound: .click)
//                            }
//                        }
//                        heavyHaptic()
//                    }) {
//                        Text("Settings")
//                            .font(.custom("RoundsBlack", size: 25))
//                            .foregroundColor(Color("textColor"))
//                            .frame(width: 255, height: 80) // Adjusted width
//                            .background(Color("pauseColor"))
//                            .cornerRadius(25)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 25)
//                                    .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
//                            )
//                            .shadow(
//                                color: Color.black.opacity(0.5),
//                                radius: 6,
//                                x: 0,
//                                y: 0
//                            )
//                    }
//                    
//                    .scaleEffect(isSettingsButtonPressed ? 0.0 : 1.0)
//                    .buttonStyle(CustomButtonStyle())
//                    .onTapGesture {
//                        withTransaction(Transaction(animation: nil)) {
//                            scene.state = .settings
//                            isSettingsButtonPressed = true
//                        }
//                        heavyHaptic()
//                    }
                    
                    Button(action: {
                        withAnimation{
                            game.endGame()
                            scene.state = .mainmenu
                            heavyHaptic()
                            isMainMenuButtonPressed = true
                            if isSoundEnabled {
                                SoundManager.instance.playSound(sound: .click)
                            }
                        }
                        heavyHaptic()
                    }) {
                        Text("Main Menu")
                            .font(.custom("RoundsBlack", size: 25))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 255, height: 80) // Adjusted width
                            .background(Color("pauseColor"))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                            )
                            .shadow(
                                color: Color.black.opacity(0.5),
                                radius: 6,
                                x: 0,
                                y: 0
                            )
                    }
                    
                    .scaleEffect(isMainMenuButtonPressed ? 0.0 : 1.0)
                    .buttonStyle(CustomButtonStyle())
                    .onTapGesture {
                        withTransaction(Transaction(animation: nil)) {
                            scene.state = .settings
                            isMainMenuButtonPressed = true
                        }
                        heavyHaptic()
                    }
                    
                }
            }
            
        }
    }
    
    
    struct Pause_menu_Previews: PreviewProvider {
        static var previews: some View {
            Pause_menu(scene: diffViews(), game: Math())
        }
    }
    
}
