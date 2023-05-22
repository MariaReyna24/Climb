//
//  endGameMenu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI

struct End_Game_menu: View {
    @ObservedObject var game : Math
    @ObservedObject var scene: diffViews
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    @State var gameRestarted = false
    var body: some View {
        if gameRestarted {
            // Restart the game
        } else {
            ZStack {
                VStack() {
                    Text("Game Over!")
                        .foregroundColor(.red)
                        .font(.custom("RoundsBlack", size: 40))
                        .fontWeight(.bold)
                        .padding()
                        .onAppear{
                            if isSoundEnabled{
                                SoundManager.instance.playSound(sound: .fail)
                            }
                        }
                    HStack() {
                        Button(" Retry") {
                            gameRestarted = true
                            game.retryLevel()
                            
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .font(.custom("RoundsBlack", size: 20))
                        
                        Button("Main Menu") {
                            scene.state = .mainmenu
                            game.leaderboard()
                        }
                        .font(.custom("RoundsBlack", size: 20))
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                }
                    
                }.background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .frame(width: 300, height: 300)
                .foregroundColor(.black)
            }
        }
    }
struct End_Game_menu_Previews: PreviewProvider {
    static var previews: some View {
        End_Game_menu(game: Math(), scene: diffViews())
    }
}

