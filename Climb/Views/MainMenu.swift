//
//  MainMenu.swift
//  Climb
//
//  Created by Hadi Chamas  on 2/14/23.
//

import SwiftUI
import GameKit

struct MainMenuView: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game : Math
    @State var isAuth = false
    var body: some View {
        ZStack {
            PlainBackground()
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 150)
                    //.shadow(color: .white, radius: )
                    .offset(y: -30)
                
                VStack (spacing: 25) {
                    Button("New Game") {
                        scene.state = .game
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 30))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 275, height: 80)
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                        
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                    
                    Button("Settings") {
                        scene.state = .settings
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 30))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 275, height: 80) // Adjusted width
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                    
                    Button("Leaderboard") {
                        scene.state = .leaderboard
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 30))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 275, height: 80) // Adjusted width
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                }
                
            }.onAppear {
                game.isOperationSelected = false
                game.authenticateUser()
                game.endGame()
                if UserDefaults.standard.object(forKey: UserDefaultKeys.hapticsEnabled) == nil {
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys.hapticsEnabled)
                    
                }
            }
        }
        
    }
    
}


struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(scene: diffViews(), game: Math())
    }
}
