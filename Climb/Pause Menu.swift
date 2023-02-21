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
 @Binding var isPaused: Bool
    var body: some View {
        ZStack {
            Color("pauseColor").opacity(0.7)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Paused")
                    .font(.largeTitle)
                    .foregroundColor(Color.red)
                Button("Resume"){
                    isPaused = false
                    
                }
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("textColor"))
            }.frame(width: 250,height: 150)
                .background(Color("myColor").opacity(0.9))
        }
    }
    struct Pause_menu_Previews: PreviewProvider {
        static var previews: some View {
            Pause_menu(isPaused: .constant(true) )
        }
    }
}
