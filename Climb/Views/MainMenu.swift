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
                    .shadow(color: .black, radius: 10)
                    .offset(y: -100)
                
                Button("New Game") {
                    scene.state = .game
                    game.retryLevel()
                    heavyHaptic()
                }
                .padding()
                .foregroundColor(Color("textColor"))
                .background(Color("myColor"))
                .cornerRadius(10)
                
                
                Button("Settings"){
                    scene.state = .settings
                    heavyHaptic()
                }
                .padding()
                .foregroundColor(Color("textColor"))
                .background(Color("myColor"))
                .cornerRadius(10)
                
                Button("Leaderboard") {
                    scene.state = .leaderboard
                        heavyHaptic()
                }
                .padding()
                .foregroundColor(Color("textColor"))
                .background(Color("myColor"))
                .cornerRadius(10)
               
                
//            }.onAppear {
//                    game.authenticateUser()
   
               }
            }
            
        }
        
    }


struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(scene: diffViews(), game: Math())
    }
}
