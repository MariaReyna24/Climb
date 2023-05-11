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
                    .frame(width: 250, height: 110)
                    .background(Rectangle().fill(Color.black).opacity(0.9))

                Button("Continue") {
                    game.newLevel()
                    dismiss()
                    game.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 250, height: 50)
                .background(.black)
                .opacity(0.9)

                Button("Main Menu") {
                    scene.state = .mainmenu
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 250, height: 50)
                .background(.black)
                .opacity(0.9)
            }
        }
    }
}

struct levelCompleted_Previews: PreviewProvider {
    static var previews: some View {
        levelCompleted(scene: diffViews(), game: Math())
    }
}

