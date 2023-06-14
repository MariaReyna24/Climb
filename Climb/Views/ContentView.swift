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
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    @State private var showinglevelComplete = false
    @State private var isPauseButtonPressed = false
    var body: some View {
            GeometryReader { geometry in
                NavigationStack {
                    ZStack {
                        GameBackground()
                            .ignoresSafeArea(.all)
                    if game.isOperationSelected {
                        VStack {
                            Text("Level \(game.levelnum)")
                                .font(Font.custom("RoundsBlack", size: 20))
                                .offset(y:-25)
                            
                            Text("Score: \(game.score)")
                                .font(Font.custom("RoundsBlack", size: 30))
                                .padding(40)
                            //.frame(width: 200, height: 50)
                            Group {
                                buttonsForAnswers(startIndex: 0, endIndex: 1)
                                buttonsForAnswers(startIndex: 1, endIndex: 3)
                                buttonsForAnswers(startIndex: 3, endIndex: 6)
                                buttonsForAnswers(startIndex: 6, endIndex: 10)
                                //TEXT FOR PROBLEMS
                                
                                
                                Text("\(game.firstNum) \(operationSymbol(for: game.operation)) \(game.secondNum)")
                                    .fontWeight(.bold)
                                    .font(.custom("RoundsBlack", size: 40))
                                    .offset(y:30)
                            }
                            
                            //  .offset(y:0)
                            Spacer()
                            
                        }
                        .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                        .onAppear {
                            game.generateAnswers()
                            heavyHaptic()
                        }
                        
                        // Timer logic
                        .onReceive(game.timer) { time in
                            if !game.isPaused && game.timeRemaining > 0 {
                                game.timeRemaining -= 1
                            }
                            // Stop the timer when the level is complete
                            if game.greenButtonCount == 10 {
                                game.timer.upstream.connect().cancel()
                            }
                        }
                        
                        // Display for the top part of the app
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    withAnimation{
                                        game.timer.upstream.connect().cancel()
                                        heavyHaptic()
                                        scene.state = .pauseMenu
                                        game.isPaused = true
                                        isPauseButtonPressed = true
                                    }
                                    heavyHaptic()
                                }){
                                    Text("Pause")
                                        .disabled(game.isGameMenuShowing || game.isLevelComplete)
                                        .font(.custom("RoundsBlack", size: 20))
                                        .foregroundColor(Color("myColor"))
                                        .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                                        .fullScreenCover(isPresented: $showingSheet) {
                                            Pause_menu(scene: scene, game: game)
                                        }
                                        .scaleEffect(isPauseButtonPressed ? 0.0 : 1.0)
                                        .buttonStyle(CustomButtonStyle())
                                        .onTapGesture {
                                            withTransaction(Transaction(animation: nil)) {
                                                scene.state = .pauseMenu
                                                game.isPaused = true
                                                isPauseButtonPressed  = true
                                                if isSoundEnabled {
                                                    SoundManager.instance.playSound(sound: .click)
                                                }
                                            }
                                            heavyHaptic()
                                        }
                                }
                            }
                          
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Text("\(game.timeRemaining)s")
                                    .font(.custom("RoundsBlack", size: 30))
                                    .foregroundColor(Color("myColor"))
                                    .fontWeight(.bold)
                                    .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                            }
                        }
                        if game.isGameMenuShowing == true {
                            GameBackground()
                                .blur(radius: 10)
                        }
                        if game.isLevelComplete == true {
                            GameBackground()
                                .blur(radius: 10)
                        }
                        if game.timeRemaining == 0 {
                            End_Game_menu(game: game, scene: scene)
                                .onAppear {
                                    game.isGameMenuShowing = true
                                }
                        }
                        if game.greenButtonCount == 10 {
                            levelCompleted(scene: scene, game: game)
                                .onAppear {
                                    game.isLevelComplete = true
                                }
                        }
                    } else {
                        OperationsView(scene: scene, game: game)
                    }
                }
                
            }
            
        }
    }
    
    func buttonsForAnswers(startIndex: Int, endIndex: Int) -> some View {
        HStack {
            withAnimation(.easeIn(duration: 0.5)) {
                ForEach(startIndex..<endIndex, id: \.self) { index in
                    if index < game.choicearry.count {
                        ClimbButton(num: game.choicearry[index], game: game)
                    }
                }
            }
        }
    }
    
    // Function to get the symbol corresponding to the operation
    func operationSymbol(for operation: Math.Operation) -> String {
        switch operation {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(scene: diffViews(), game: Math())
    }
}
