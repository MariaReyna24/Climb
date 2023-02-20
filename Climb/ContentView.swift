//
//  ContentView.swift
//  Climb
//
//  Created by Maria Reyna  on 2/1/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject var game = Math()
    var body: some View {
        NavigationView{
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
                    
                    //this is the equation
                    Text("\(game.firstNum) + \(game.secondNum)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    //this displays the generated answers on appear.
                }.onAppear {
                    game.generateAnswers()
                }
                
                //this is for the timer of the app
                .onReceive(timer) {time in   // Adds an action to perform when this view detects data emitted by the given publisher.
                    if game.timeRemaining > 0  {   //lets the counter count down so it dosent go past 0 into negative numbers
                        game.timeRemaining -= 1
                    }
                }
                
            
                //the display for the top part of the app
                .navigationTitle("Level 1")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("Pause"){
                            game.isPaused = true
                            timer.upstream.connect().cancel()
                            
                           
                        }.font(.title2)
                        .foregroundColor(.red)
                        .disabled(true)
                        .opacity(0.5)
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Text("\(game.timeRemaining)s") //shows the time on the screen
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                }
                .background((Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: 393, height: 918)
                ))
                if game.timeRemaining == 0 {
                    End_Game_menu(game: game)
                }
                if game.isPaused == true {
                    Pause_menu(isPaused: $game.isPaused)
                }
                if game.greenButtonCount == 10 {
                    levelCompleted()
                }
            }
        } .navigationBarBackButtonHidden(true)
    }
    
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
        }
    }
}
