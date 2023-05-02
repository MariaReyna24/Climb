//
//  ContentView.swift
//  Climb
//
//  Created by Maria Reyna  on 2/1/23.
//

import Foundation
import SwiftUI
struct ContentView: View {
    @StateObject var game = Math()
    @State private var showingSheet = false
    @State var isshowing = false
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 15){
                    //this is the score
                    Text("Score: \(game.score)")
                        .font(.largeTitle)
                    Spacer()
                    
                    buttonsForAnswers(startIndex: 0, endIndex: 1)
                    buttonsForAnswers(startIndex: 1, endIndex: 3)
                    buttonsForAnswers(startIndex: 3, endIndex: 6)
                    buttonsForAnswers(startIndex: 6, endIndex: 10)
                    
                    //this is the equation being displayed on screen
                    Text("\(game.firstNum) + \(game.secondNum)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    //this displays the generated answers on appear.
                }.onAppear {
                    game.generateAnswers()
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
                .navigationTitle("Level \(game.levelnum)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("Pause"){
                            game.timer.upstream.connect().cancel()
                            showingSheet.toggle()
                            
                        }.font(.title2)
                            .foregroundColor(.red)
                            .fullScreenCover(isPresented: $showingSheet) {
                                Pause_menu(game: game)
                            }
                    }
                    //timer in the right hand corner
                    ToolbarItem(placement: .navigationBarTrailing){
                        Text("\(game.timeRemaining)s")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                }
                //shows end game menu when time runs out
                if game.timeRemaining == 0 {
                    End_Game_menu(game: game)
                }
                //code for the pause menu
                if game.isPaused == true {
                    Pause_menu(game: game)
                }
                //This logic handles the level completing action
                if game.greenButtonCount == 10 {
                    levelCompleted(game: game)
                }
                
            }
            .ignoresSafeArea()
            .background {
                Image("background")
                    .ignoresSafeArea()
            }
            // hides the navigation back button
        } .navigationBarBackButtonHidden(true)
    }
    //func for layout for our buttons
    func buttonsForAnswers(startIndex: Int, endIndex: Int) -> some View {
        HStack {
            ForEach(startIndex..<endIndex, id: \.self) { index in
                if index < game.choicearry.count {
                    button(num:game.choicearry[index], game: game)
                }
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
                .previewDisplayName("dark")
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
        }
    }
}
