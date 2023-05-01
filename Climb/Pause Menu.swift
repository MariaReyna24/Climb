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
    @Environment(\.dismiss) var dismiss
    @ObservedObject var game : Math
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
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
                    
                    NavigationLink(destination: MainMenuView(), label: {
                        Text("Main Menu")
                            .font(.title)
                            .padding()
                            .background(Color("myColor"))
                            .foregroundColor(Color("textColor"))
                    }
                    )}
            } .background((Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: 393, height: 918)
            ))
        }
        
    }
}

struct Pause_menu_Previews: PreviewProvider {
    static var previews: some View {
        Pause_menu(game: Math())
    }
}

