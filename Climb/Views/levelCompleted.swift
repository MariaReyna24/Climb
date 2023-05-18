//
//  levelCompleted.swift
//  Climb
//
//  Created by Maria Reyna  on 2/20/23.
//

import SwiftUI

struct levelCompleted: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Text("Level Completed!")
                    .foregroundColor(.green)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Button("Continue") {
                    game.newLevel()
                    dismiss()
                    game.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                .opacity(0.9)
             

                Button("Main Menu") {
                    scene.state = .mainmenu
                    game.retryLevel()
                    game.leaderboard()
                }
              
                .foregroundColor(.white)
                .fontWeight(.bold)
                .opacity(0.9)
                .padding()
            }
        }.background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
            .frame(width: 300, height: 300)
            
            
    }
}

struct levelCompleted_Previews: PreviewProvider {
    static var previews: some View {
        levelCompleted(scene: diffViews(), game: Math())
    }
}

