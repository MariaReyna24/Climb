import SwiftUI
import GameKit


struct MainMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    @State private var isNewGameButtonPressed = false
    @State private var isSettingsButtonPressed = false
    @State private var isLeaderboardButtonPressed = false
    var body: some View {
        ZStack {
            BouncingLogoAnimation()
                .offset(y:-10)
            
            
            VStack(spacing: 25) {
                Button(action: {
                    withAnimation {
                        scene.state = .game
                        isNewGameButtonPressed = true
                        if isSoundEnabled {
                            SoundManager.instance.playSound(sound: .click)
                        }
                    }
                    heavyHaptic()
                }) {
                    Text("New Game")
                        .font(.custom("RoundsBlack", size: 28))
                        .foregroundColor(Color("textColor"))
                        .frame(width: 255, height: 80)
                        .background(Color("pauseColor"))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("WhiteDM"), lineWidth: 6)
                        )
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 8,
                            x: 0,
                            y: 0
                        )
                }
                .scaleEffect(isNewGameButtonPressed ? 0.0 : 1.0)
                .buttonStyle(CustomButtonStyle())
                .onTapGesture {
                    withTransaction(Transaction(animation: nil)) {
                        scene.state = .game
                        isNewGameButtonPressed = true
                    }
                    heavyHaptic()
                }
                .offset(y: 40)
                
                Button(action: {
                    withAnimation {
                        scene.state = .settings
                        isSettingsButtonPressed = true
                        if isSoundEnabled {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                    }
                    heavyHaptic()
                }) {
                    Text("Settings")
                        .font(.custom("RoundsBlack", size: 30))
                        .foregroundColor(Color("textColor"))
                        .frame(width: 255, height: 80)
                        .background(Color("pauseColor"))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("WhiteDM"), lineWidth: 6)
                        )
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 8,
                            x: 0,
                            y: 0
                        )
                }
                .scaleEffect(isSettingsButtonPressed ? 0.9 : 1.0)
                .buttonStyle(CustomButtonStyle())
                .onTapGesture {
                    withTransaction(Transaction(animation: nil)) {
                        scene.state = .settings
                        isSettingsButtonPressed = true
                    }
                    heavyHaptic()
                }
                .offset(y: 45)
                
                Button(action: {
                    withAnimation {
                        scene.state = .leaderboard
                        isLeaderboardButtonPressed = true
                        if isSoundEnabled {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                    }
                    heavyHaptic()
                }) {
                    Text("Leaderboard")
                        .font(.custom("RoundsBlack", size: 25))
                        .foregroundColor(Color("textColor"))
                        .frame(width: 255, height: 80)
                        .background(Color("pauseColor"))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("WhiteDM"), lineWidth: 6)
                        )
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 8,
                            x: 0,
                            y: 0
                        )
                }
                .scaleEffect(isLeaderboardButtonPressed ? 0.9 : 1.0)
                .buttonStyle(CustomButtonStyle())
                .onTapGesture {
                    withTransaction(Transaction(animation: nil)) {
                        scene.state = .leaderboard
                        isLeaderboardButtonPressed = true
                    }
                    heavyHaptic()
                }
                .offset(y: 50)
            }
        }
        .onAppear {
            game.isOperationSelected = false
            game.authenticateUser()
            game.endGame()
            game.isPaused = false
            if UserDefaults.standard.object(forKey: UserDefaultKeys.hapticsEnabled) == nil {
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.hapticsEnabled)
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(scene: diffViews(), game: Math())
    }
}


