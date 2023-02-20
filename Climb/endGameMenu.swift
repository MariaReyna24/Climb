//
//  endGameMenu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI

struct End_Game_menu: View {
    @ObservedObject var game : Math
    @State var gameRestarted = false
    var body: some View {
        if gameRestarted {
            // Restart the game
        } else {
            ZStack {
                VStack(spacing: 0) {
                    Text("Game Over!")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: 200, height: 110)
                        .background(Rectangle().fill(Color.black))
                    HStack(spacing: 0) {
                        Button("Retry") {
                            gameRestarted = true
                            game.self.score = 0 
                            game.timeRemaining = 15
                            game.generateAnswers()
                            game.correctAnsArry = []
                        }
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(.black)
                }
            }
        }
    }
}
struct End_Game_menu_Previews: PreviewProvider {
    static var previews: some View {
        End_Game_menu(game: Math())
    }
}

