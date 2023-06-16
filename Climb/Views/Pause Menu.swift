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
                
                VStack(spacing: 33) {
                    Text("Current score: \(game.score)")
                        .font(.custom("RoundsBlack", size: 35))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
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
                            .font(.custom("RoundsBlack", size: 40))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 295, height: 100)
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
                    
                    VStack(spacing: 30) {
                        HStack {
                            Text("Haptics")
                                .font(.custom("RoundsBlack", size: 32))
                                .foregroundColor(Color("textColor"))
                                .padding()
                            
                            //Spacer()
                            
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
                        .padding(.horizontal)
                        .frame(width: 295, height: 100)
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
                        
                        HStack {
                            Text("Sound")
                                .font(.custom("RoundsBlack", size: 35))
                                .foregroundColor(Color("textColor"))
                                .padding(23)
                                
                            
                            //Spacer()
                            
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
                        .padding(.horizontal)
                        .frame(width: 295, height: 100)
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
                            .font(.custom("RoundsBlack", size: 35))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 295, height: 100)
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
                .overlay(
                    TimerView(timeRemaining: game.timeRemaining)
                        .font(.custom("RoundsBlack", size: 30))
                        .foregroundColor(Color("myColor"))
                        .fontWeight(.bold)
                        .padding(.top, -130)
                        .padding(.trailing, -18),
                    alignment: .topTrailing
                )
            }
        }
    }
}

struct TimerView: View {
    let timeRemaining: Int
    
    var body: some View {
        Text("\(timeRemaining)s")
    }
}

struct Pause_menu_Previews: PreviewProvider {
    static var previews: some View {
        Pause_menu(scene: diffViews(), game: Math())
    }
}
