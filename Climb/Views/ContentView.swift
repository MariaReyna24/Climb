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
                    .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                
                VStack {
                    Text("Level \(game.levelnum)")
                        .font(Font.custom("RoundsBlack", size: 20))
                    
                    Text("Score: \(game.score)")
                        .font(.custom("RoundsBlack", size: 30))
                        .padding(37)
                    
                    OperationsView(scene: scene, game: game) // Add OperationsView to display the operation selection buttons
                    
                    Group {
                        buttonsForAnswers(startIndex: 0, endIndex: 1)
                        buttonsForAnswers(startIndex: 1, endIndex: 3)
                        buttonsForAnswers(startIndex: 3, endIndex: 6)
                        buttonsForAnswers(startIndex: 6, endIndex: 10)
                        Text("\(game.firstNum) \(operationSymbol(for: game.operation)) \(game.secondNum)") // Use operationSymbol() to display the correct symbol based on the operation
                            .fontWeight(.bold)
                            .font(.custom("RoundsBlack", size: 40))
                    }
                    
                    Spacer()
                }
                .blur(radius: game.isGameMenuShowing || game.isLevelComplete ? 100 : 0)
                .onAppear {
                    game.generateAnswers(state: diffViews())
                    heavyHaptic()
                }
                
                // Rest of your code...
            }
        }
    }
    
    // Function for layout for the answer buttons
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
