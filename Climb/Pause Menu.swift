//
//  Pause Menu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import UIKit
import Foundation

struct Pause_menu: View {
    @ObservedObject var scene: diffViews
    @Environment(\.dismiss) var dismiss
    @ObservedObject var game : Math
    var body: some View {
            ZStack {
                Image("climbss")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Text("Current score: \(game.score)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                    Button("Resume") {
                        dismiss()
                        game.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                    .font(.title)
                    .padding()
                    .background(Color("myColor"))
                    .foregroundColor(Color("textColor"))
                    
                    
                    Button("Main Menu") {
                        scene.state = .mainmenu
                        game.retryLevel()
                    }
                    .font(.title)
                    .padding()
                    .background(Color("myColor"))
                    .foregroundColor(Color("textColor"))
                    
                    
                }
            }
        }
        
    }


struct Pause_menu_Previews: PreviewProvider {
    static var previews: some View {
        Pause_menu(scene: diffViews(), game: Math())
    }
}

