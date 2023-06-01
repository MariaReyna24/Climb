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
            Button("+") {
                game.operation = .addition
                game.isOperationSelected = true
                heavyHaptic()
            }
            .font(.custom("RoundsBlack", size: 40))
            .foregroundColor(Color("textColor"))
            .frame(width: 200, height: 60)
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
            
            Button("-") {
                game.operation = .subtraction
                game.isOperationSelected = true
                heavyHaptic()
            }
            .font(.custom("RoundsBlack", size: 40))
            .foregroundColor(Color("textColor"))
            .frame(width: 200, height: 60)
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
            Button("x") {
                game.operation = .subtraction
                game.isOperationSelected = true
                heavyHaptic()
            }
            .font(.custom("RoundsBlack", size: 35))
            .foregroundColor(Color("textColor"))
            .frame(width: 200, height: 60)
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
            .disabled(true)
            .opacity(0.5)

            Button("÷") {
                game.operation = .subtraction
                game.isOperationSelected = true
                heavyHaptic()
            }
            .font(.custom("RoundsBlack", size: 45))
            .foregroundColor(Color("textColor"))
            .frame(width: 200, height: 60)
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
            .disabled(true)
            .opacity(0.5)

        }
    }
}

struct OperationsView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsView(scene: diffViews(), game: Math())
    }
}
