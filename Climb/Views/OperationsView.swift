//
//  OperationsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/31/23.
//

import SwiftUI

struct OperationsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    
    @State private var isAdditionButtonPressed = false
    @State private var isSubtractionButtonPressed = false
    
    
    var body: some View {
        NavigationStack{
            
            
            ZStack {
                PlainBackground()
                    .offset(y:-50)
                
                Image("Operations")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
                    .offset(y: colorScheme == .light ? -0 : 75)
                    .offset(x:-15, y:-370)
                    .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                
                
                VStack(spacing: 30) {
                    
                    
                    Button(action: {
                        withAnimation {
                            scene.state = .game
                            game.operation = .addition
                            game.isOperationSelected = true
                            isAdditionButtonPressed = true
                        }
                        heavyHaptic()
                    }) {
                        Text("+")
                            .font(.custom("RoundsBlack", size: 60))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 250, height: 80)
                            .background(Color("pauseColor"))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("WhiteDM"), lineWidth: 6)
                            )
                            .shadow(
                                color: Color.white.opacity(0.5),
                                radius: 6,
                                x: 0,
                                y: 0
                            )
                    }
                    .scaleEffect(isAdditionButtonPressed ? 0.0 : 1.0)
                    .buttonStyle(CustomButtonStyle())
                    .onTapGesture {
                        withTransaction(Transaction(animation: nil)) {
                            scene.state = .game
                            isAdditionButtonPressed = true
                        }
                        heavyHaptic()
                    }
                    
                    
                    
                    Button(action: {
                        withAnimation {
                            scene.state = .game
                            game.operation = .subtraction
                            game.isOperationSelected = true
                            isSubtractionButtonPressed = true
                        }
                        heavyHaptic()
                    }) {
                        Text("-")
                            .font(.custom("RoundsBlack", size: 60))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 250, height: 80)
                            .background(Color("pauseColor"))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("WhiteDM"), lineWidth: 6)
                            )
                            .shadow(
                                color: Color.white.opacity(0.5),
                                radius: 6,
                                x: 0,
                                y: 0
                            )
                    }
                    .scaleEffect(isSubtractionButtonPressed ? 0.0 : 1.0)
                    .buttonStyle(CustomButtonStyle())
                    .onTapGesture {
                        withTransaction(Transaction(animation: nil)) {
                            scene.state = .game
                            isSubtractionButtonPressed = true
                        }
                        heavyHaptic()
                    }
                    
                    
                    Button("🔒") {
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
                        //  game.operation = .subtraction
                        //  game.isOperationSelected = true
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
                
            }
            
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    scene.state = .mainmenu
                    heavyHaptic()
                }label: {
                    Image("BackButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height:200)
                        .offset( x:-60, y: 45)
                    //.offset(y: colorScheme == .light ? 50 : 13)
                    // .offset(x: colorScheme == .light ? -3 : -5)
                        .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                }
            }
        }
    }
}
struct OperationsView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsView(scene: diffViews(), game: Math())
        OperationsView(scene: diffViews(), game: Math()).preferredColorScheme(.dark)
    }
}
