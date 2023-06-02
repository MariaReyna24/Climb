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
    @State private var isPresentingSettings = false
    var body: some View {
        ZStack {
            Image("climbss")
                .resizable()
                .ignoresSafeArea()
            VStack (spacing: 20){
                Text("Current score: \(game.score)")
                    .font(.custom("RoundsBlack", size: 25))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Button("Resume") {
                    dismiss()
                    game.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    heavyHaptic()
                }
                .font(.custom("RoundsBlack", size: 25))
                .foregroundColor(Color("textColor"))
                .frame(width: 200, height: 60) // Adjusted width
                .background(Color("pauseColor"))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                )
                .shadow(
                    color: Color.black.opacity(0.5),
                    radius: 6,
                    x: 0,
                    y: 0
                )
                Button("Settings") {
                    scene.state = .settings
                    heavyHaptic()
                }
                .font(.custom("RoundsBlack", size: 25))
                .foregroundColor(Color("textColor"))
                .frame(width: 200, height: 60) // Adjusted width
                .background(Color("pauseColor"))
                            
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                    )
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 6,
                            x: 0,
                            y: 0
                        )
                Button("Main Menu") {
                    game.endGame()
                    scene.state = .mainmenu
                    heavyHaptic()
                }
                .font(.custom("RoundsBlack", size: 25))
                .foregroundColor(Color("textColor"))
                .frame(width: 200, height: 60) // Adjusted width
                .background(Color("pauseColor"))
                            
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                    )
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 6,
                            x: 0,
                            y: 0
                        )
                          
                            
                            
                
            }
        }
       
        
    }
    
    
    struct Pause_menu_Previews: PreviewProvider {
        static var previews: some View {
            Pause_menu(scene: diffViews(), game: Math())
        }
    }
    
}
