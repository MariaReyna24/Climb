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
                
                VStack() {
                    //this is the score
                    Text("Level \(game.levelnum)")
                        
                        .frame(alignment: .top)
                        .font(.custom("RoundsBlack", size: 15))
                        .padding()
                        Text("Score: \(game.score)")
                        .font(.custom("RoundsBlack", size: 25))
                       
                    
                    Group {
                        buttonsForAnswers(startIndex: 0, endIndex: 1)
                        buttonsForAnswers(startIndex: 1, endIndex: 3)
                        buttonsForAnswers(startIndex: 3, endIndex: 6)
                        buttonsForAnswers(startIndex: 6, endIndex: 10)
                        Text("\(game.firstNum) + \(game.secondNum)")
                            .fontWeight(.bold)
                            .font(.custom("RoundsBlack", size: 40))
                    }
                    .offset(y: 75)
                    Spacer()
                    
                }.onAppear {
                    game.generateAnswers()
                   heavyHaptic()
                    
                }
                
                //this is for the timer of the app and where it stops the countdown from going past zero
                .onReceive(game.timer) {time in
                    if !game.isPaused && game.timeRemaining > 0 {
                        game.timeRemaining -= 1
                    }
                    //this logic helps stop the timer when the level is complete
                    if game.greenButtonCount == 10 {
                        game.timer.upstream.connect().cancel()
                    }
                }
                
                //the display for the top part of the app
//                .navigationBarTitle("Level \(game.levelnum)", displayMode: .inline)
//                           .font(Font.custom("RoundsBlack", size: 25))

                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Pause") {
                            game.timer.upstream.connect().cancel()
                            showingSheet.toggle()
                            
                        }.font(.custom("RoundsBlack", size: 20))
                            .foregroundColor(.black)
                            .fullScreenCover(isPresented: $showingSheet) {
                                Pause_menu(scene: scene, game: game)
                            }
                    }
                    //timer in the right hand corner
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("\(game.timeRemaining)s")
                            .font(.custom("RoundsBlack", size: 30))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            
                    }
                }
                //shows end game menu when time runs out
                if game.timeRemaining == 0 {
                    End_Game_menu(game: game, scene: scene)
                }
                //code for the pause menu
                if game.isPaused == true {
                    Pause_menu(scene: scene, game: game)
                }
                //This logic handles the level completing action
                if game.greenButtonCount == 10 {
                    levelCompleted(scene: scene, game: game)
                }
            }
        }
        
    }
    //func for layout for our buttons
    func buttonsForAnswers(startIndex: Int, endIndex: Int) -> some View {
        HStack {
            ForEach(startIndex..<endIndex, id: \.self) { index in
                if index < game.choicearry.count {
                    ClimbButton(num:game.choicearry[index], game: game)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(scene: diffViews(), game: Math())
        //        ContentView()
        //            .preferredColorScheme(.dark)
        //            .previewDisplayName("dark")
        //        ContentView()
        //            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
    }
}

