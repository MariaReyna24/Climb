import SwiftUI

struct End_Game_menu: View {
    @ObservedObject var game: Math
    @ObservedObject var scene: diffViews
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    @State var gameRestarted = false
    @State private var showGameOver = false
    @State private var showMenu = false
    
    var body: some View {
        if gameRestarted {
            // Restart the game
        } else {
            ZStack {
                VStack(spacing: 20) {
                    Text("Game Over!")
                        .foregroundColor(.red)
                        .font(.custom("RoundsBlack", size: 48))
                        .fontWeight(.bold)
                        .padding()
                        .scaleEffect(showGameOver ? 1.0 : 0.0) // Apply scale effect based on the showGameOver state
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showGameOver)
                    
                    HStack {
                        Text(" final Score: ")
                            .foregroundColor(.white)
                            .font(.custom("RoundsBlack", size: 25))
                            .fontWeight(.bold)
                        Text("\(game.score)")
                            .foregroundColor(.yellow)
                            .font(.custom("RoundsBlack", size: 25))
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        Button("Retry") {
                            gameRestarted = true
                            game.retryLevel()
                            heavyHaptic()
                            game.isGameMenuShowing = false
                            if isSoundEnabled {
                                SoundManager.instance.playSound(sound: .click)
                            }
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .font(.custom("RoundsBlack", size: 25))
                        
                        Button("Main Menu") {
                            scene.state = .mainmenu
                            game.leaderboard()
                            game.endGame()
                            heavyHaptic()
                            game.isGameMenuShowing = false
                            if isSoundEnabled {
                                SoundManager.instance.playSound(sound: .click)
                            }
                        }
                        .font(.custom("RoundsBlack", size: 25))
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                }
                .background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .frame(width: 350, height: 800)
                .foregroundColor(.black)
                .offset(y: showMenu ? 0 : -800) // Offset the entire box vertically
                .onAppear {
                    if isSoundEnabled {
                        SoundManager.instance.playSound(sound: .fail)
                    }
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) { // Adjust the duration of the falling animation
                        showMenu = true // Start the falling animation for the entire box
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            showGameOver = true // Start the "Game Over" animation after a delay of 0.75 seconds
                        }
                    }
                }
            }
            
        }
    }
}

struct End_Game_menu_Previews: PreviewProvider {
    static var previews: some View {
        End_Game_menu(game: Math(), scene: diffViews())
    }
}
