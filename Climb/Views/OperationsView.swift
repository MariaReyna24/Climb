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
        NavigationStack{
            ZStack {
                PlainBackground()
                    .offset(y:-50)
                VStack(spacing: 30) {
                    Button("+") {
                        game.operation = .addition
                        game.isOperationSelected = true
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 60))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 250, height: 80)
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                        
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                    
                    Button("-") {
                        game.operation = .subtraction
                        game.isOperationSelected = true
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 60))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 250, height: 80)
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                        
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                    Button("🔒") {
                        game.operation = .subtraction
                        game.isOperationSelected = true
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size: 55))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 250, height: 80)
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                        
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                    .disabled(true)
                    .opacity(0.5)
                    
                    Button("🔒") {
                        game.operation = .subtraction
                        game.isOperationSelected = true
                        heavyHaptic()
                    }
                    .font(.custom("RoundsBlack", size:55))
                    .foregroundColor(Color("textColor"))
                    .frame(width: 250, height: 80)
                    .background(Color("pauseColor"))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("WhiteDM"), lineWidth: 6) // Thicker outline
                    )
                    .shadow(
                        color: Color.white.opacity(0.5),
                        radius: 6,
                        x: 0,
                        y: 0
                    )
                    .padding(.bottom)
                    .disabled(true)
                    .opacity(0.5)
                    
                }
                
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        scene.state = .mainmenu
                        heavyHaptic()
                    }label: {
                        Label("Back", systemImage: "chevron.backward")
                    }
                    
                    .font(.title2)
                    .foregroundColor(Color("myColor"))
                }
                
            }
        }
    }
}
struct OperationsView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsView(scene: diffViews(), game: Math())
    }
}
