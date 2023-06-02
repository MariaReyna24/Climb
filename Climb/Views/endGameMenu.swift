import SwiftUI
struct End_Game_menu: View {
    @ObservedObject var game: Math
    @ObservedObject var scene: diffViews
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    @State var gameRestarted = false
    
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
                        .onAppear {
                            if isSoundEnabled {
                                SoundManager.instance.playSound(sound: .fail)
                            }
                        }
                    HStack{
                        Text("Your final Score: ")
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
                        }
                        .font(.custom("RoundsBlack", size: 25))
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        
                    }
                }
                .background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    .frame(width: 350, height: 250)
                    .foregroundColor(.black)
            
            }
        }
    }
}

struct End_Game_menu_Previews: PreviewProvider {
    static var previews: some View {
        End_Game_menu(game: Math(), scene: diffViews())
    }
}
