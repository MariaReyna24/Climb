import SwiftUI

struct Pause_menu: View {
    @ObservedObject var scene: diffViews
    @Environment(\.dismiss) var dismiss
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    @State private var isResumeButtonPressed = false
    @State private var isMainMenuButtonPressed = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GameBackground()
                    .ignoresSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 7)
                
                VStack(spacing: 30) {
                    Text("Current score: \(game.score)")
                        .font(.custom("RoundsBlack", size: 35))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            isHapticsEnabled.toggle()
                        }) {
                            Image(systemName: isHapticsEnabled ? "hand.point.up.left.fill" : "hand.point.up.left")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(isHapticsEnabled ? Color.green : Color.gray)
                                .cornerRadius(40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color("WhiteDM"), lineWidth: 4)
                                )
                                .shadow(
                                    color: Color.black.opacity(0.5),
                                    radius: 4,
                                    x: 0,
                                    y: 0
                                )
                        }
                        .onChange(of: isHapticsEnabled) { newValue in
                            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.hapticsEnabled)
                            if newValue {
                                // Haptics enabled
                            } else {
                                // Haptics disabled
                            }
                        }
                        
                        Button(action: {
                            isSoundEnabled.toggle()
                        }) {
                            Image(systemName: isSoundEnabled ? "speaker.wave.3.fill" : "speaker.slash.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(isSoundEnabled ? Color.green : Color.gray)
                                .cornerRadius(40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color("WhiteDM"), lineWidth: 4)
                                )
                                .shadow(
                                    color: Color.black.opacity(0.5),
                                    radius: 4,
                                    x: 0,
                                    y: 0
                                )
                        }
                        .onChange(of: isSoundEnabled) { newValue in
                            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.soundEnabled)
                            if isHapticsEnabled {
                                if newValue {
                                    // Sound enabled
                                } else {
                                    // Sound disabled
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        withAnimation {
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
                            .frame(width: 285, height: 90)
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
                    
                    Button(action: {
                        game.endGame()
                        scene.state = .mainmenu
                        heavyHaptic()
                        isMainMenuButtonPressed = true
                        if isSoundEnabled {
                            SoundManager.instance.playSound(sound: .click)
                        }
                    }) {
                        Text("Main Menu")
                            .font(.custom("RoundsBlack", size: 25))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 285, height: 90)
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
            }
        }
    }
}

struct Pause_menu_Previews: PreviewProvider {
    static var previews: some View {
        Pause_menu(scene: diffViews(), game: Math())
    }
}
