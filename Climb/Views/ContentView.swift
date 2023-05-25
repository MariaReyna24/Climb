//
//  ContentView.swift
//  Climb
//
//  Created by Maria Reyna  on 2/1/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @State private var showingSheet = false
    @State private var showinglevelComplete = false
  
    var body: some View {
        NavigationStack {
            ZStack {
                Image("climbss")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0  )
                   
                VStack() {
                    Text("Level \(game.levelnum)")
                        .font(Font.custom("RoundsBlack", size: 20)) // Increased font size for the level title
                    // Score title
                    Text("Score: \(game.score)")
                        .font(.custom("RoundsBlack", size: 30))
                        .padding(37) // Adjusted padding to push it closer to the buttons
                        
                    Group {
                        buttonsForAnswers(startIndex: 0, endIndex: 1)
                        buttonsForAnswers(startIndex: 1, endIndex: 3)
                        buttonsForAnswers(startIndex: 3, endIndex: 6)
                        buttonsForAnswers(startIndex: 6, endIndex: 10)
                        Text("\(game.firstNum) + \(game.secondNum)")
                            .fontWeight(.bold)
                            .font(.custom("RoundsBlack", size: 40))
                    }
                    .offset(y: 0)
                    Spacer()
                    
                } .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                .onAppear {
                        game.generateAnswers()
                        heavyHaptic()
                }
                
                // Timer logic
                .onReceive(game.timer) {time in
                    if !game.isPaused && game.timeRemaining > 0 {
                        game.timeRemaining -= 1
                    }
                    //this logic helps stop the timer when the level is complete
                    if game.greenButtonCount == 10 {
                        game.timer.upstream.connect().cancel()
                    }
                }
                // Display for the top part of the app
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Pause") {
                            game.timer.upstream.connect().cancel()
                            showingSheet.toggle()
                            heavyHaptic()
                            
                        }
                        .disabled(game.isGameMenuShowing || game.isLevelComplete == true)
                        .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                        .font(.custom("RoundsBlack", size: 20))
                        .foregroundColor(Color("myColor"))
                        .fullScreenCover(isPresented: $showingSheet) {
                            Pause_menu(scene: scene, game: game)
                        }
                    }
                    
                    // Timer in the right-hand corner
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("\(game.timeRemaining)s")
                            .font(.custom("RoundsBlack", size: 30))
                            .foregroundColor(Color("myColor"))
                            .fontWeight(.bold)
                            .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                    }
                }
                
                // End game menu when time runs out
                
                if game.timeRemaining == 0 {
                        End_Game_menu(game: game, scene: scene)
                            .onAppear {
                                game.isGameMenuShowing = true
                                
                            }
                }
                
                // Code for the pause menu
                if game.isPaused == true {
                    Pause_menu(scene: scene, game: game)
                }
                
                // Logic for completing a level
                if game.greenButtonCount == 10 {
                    levelCompleted(scene: scene, game: game)
                        .onAppear {
                            game.isLevelComplete = true
                        }
                }
                
            }
        }
        
    }
    
    // Function for layout for our buttons
    func buttonsForAnswers(startIndex: Int, endIndex: Int) -> some View {
        HStack {
            withAnimation(.easeIn(duration: 0.5)){
                ForEach(startIndex..<endIndex, id: \.self) { index in
                    if index < game.choicearry.count {
                        ClimbButton(num: game.choicearry[index], game: game)
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(scene: diffViews(), game: Math())
    }
}
