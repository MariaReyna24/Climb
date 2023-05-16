//
//  MainMenu.swift
//  Climb
//
//  Created by Hadi Chamas  on 2/14/23.
//

import SwiftUI
struct MainMenuView: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game : Math
    var body: some View {
        ZStack {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 150)
                    .shadow(color: .black, radius: 10)
                    .offset(y: -180)
                
                Button("New Game") {
                    scene.state = .game
                    game.retryLevel()
                }
                .padding()
                .foregroundColor(Color("textColor"))
                .background(Color("myColor"))
                .cornerRadius(10)
                
                Button("Leaderboard") {
                    scene.state = .leaderboard
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
            
            
            }.onAppear {
                game.authenticateUser()
            }
        }.background(Image("mainMenuBackground")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(width: 393, height: 918))
        .background(Color("myColor"))
    
       
        }
        
    }
  
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(scene: diffViews(), game: Math())
    }
}
