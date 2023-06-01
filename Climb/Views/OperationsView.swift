//
//  OperationsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/31/23.
//

import SwiftUI

struct OperationsView: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Addition") {
                game.operation = .addition
                game.isOperationSelected = true
                heavyHaptic()
            }
            .font(.custom("RoundsBlack", size: 23))
            .foregroundColor(game.operation == .addition ? .white : Color("textColor")) // Update the button color based on the operation
            .frame(width: 200, height: 60)
            .background(game.operation == .addition ? Color("selectedColor") : Color("pauseColor")) // Update the button background color based on the operation
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("WhiteDM"), lineWidth: 6)
            )
            .shadow(
                color: Color.black.opacity(0.5),
                radius: 6,
                x: 0,
                y: 0
            )
            
            Button("Subtraction") {
                game.operation = .subtraction
                game.isOperationSelected = true
                heavyHaptic()
            }
            .font(.custom("RoundsBlack", size: 23))
            .foregroundColor(game.operation == .subtraction ? .white : Color("textColor")) // Update the button color based on the operation
            .frame(width: 200, height: 60)
            .background(game.operation == .subtraction ? Color("selectedColor") : Color("pauseColor")) // Update the button background color based on the operation
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("WhiteDM"), lineWidth: 6)
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

struct OperationsView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsView(scene: diffViews(), game: Math())
    }
}
