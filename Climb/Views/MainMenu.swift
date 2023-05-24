//
//  MainMenu.swift
//  Climb
//
//  Created by Hadi Chamas  on 2/14/23.
//

import SwiftUI
//import GameKit

struct MainMenuView: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game : Math
    @State var isAuth = false
    var body: some View {
        ZStack {
            Image("climbss")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 150)
                    .shadow(color: .black, radius: 20)
                    .offset(y: -100)
                
                VStack (spacing: 20) {
                    
                    
                    
                    Button("New Game") {
                        scene.state = .game
                        game.retryLevel()
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 23))
                    .foregroundColor(Color("textColor"))                    .frame(width: 200, height: 60)
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
                    
                    Button("setting") {
                        scene.state = .game
                        game.retryLevel()
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 25))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 200, height: 60) // Adjusted width
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
                    
                    Button("Leaderboard") {
                        scene.state = .leaderboard
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 20))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 200, height: 60) // Adjusted width
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
                
            }.onAppear {
                    game.authenticateUser()
                   game.retryLevel()
               }
            }
            
        }
        
    }


struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(scene: diffViews(), game: Math())
    }
}
