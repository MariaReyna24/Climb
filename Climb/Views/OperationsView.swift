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
    var body: some View {
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
                Button {
                            scene.state = .mainmenu
                           heavyHaptic()
                        }label: {
                           Image("BackButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height:200)
                                .offset( y:40)
                                .offset(y: colorScheme == .light ? 50 : 13)
                                .offset(x: colorScheme == .light ? -3 : -5)
                                .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                       }
    
                      
                       .offset(x:-155,y:-415)
                    
                
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
            //.toolbar{
//                ToolbarItem(placement: .navigationBarLeading){
//                    Button {
//                        scene.state = .mainmenu
//                        heavyHaptic()
//                    }label: {
//                        Label("Back", systemImage: "chevron.backward")
//                    }
//
//                    .font(.title2)
//                    .foregroundColor(Color("myColor"))
//                }
                
            }
        }
//    }
//}
struct OperationsView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsView(scene: diffViews(), game: Math())
        OperationsView(scene: diffViews(), game: Math()).preferredColorScheme(.dark)
    }
}
