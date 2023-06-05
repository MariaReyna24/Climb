//
//  MainMenu.swift
//  Climb
//
//  Created by Hadi Chamas  on 2/14/23.
//

import SwiftUI
import GameKit

struct MainMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @State var isAuth = false
    
    var body: some View {
        ZStack {
            PlainBackground()
            
            VStack {
                VStack (spacing: 25) {
                    Button("New Game") {
                        scene.state = .game
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 28))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 255, height: 80)
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                    )
                    .shadow(
                        color: Color.black.opacity(0.5),
                        radius: 8,
                        x: 0,
                        y: 0
                    )
                    .offset(y:40)
                    
                    Button("Settings") {
                        scene.state = .settings
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 30))
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
                        radius: 8,
                        x: 0,
                        y: 0
                    )
                    .offset(y:45)
                    
                    Button("Leaderboard") {
                        scene.state = .leaderboard
                        heavyHaptic()
                    }
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
                        radius: 8,
                        x: 0,
                        y: 0
                    )
                    .offset(y:50)
                }
                .overlay(
                    BouncingLogoAnimation()
                        .offset(y: colorScheme == .light ? -320 : -210)
                        .shadow(color: colorScheme == .light ? .black : .white, radius: 0, x: 0, y: 0)
                )
            }
            .onAppear {
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

