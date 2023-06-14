import SwiftUI

struct OperationsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    
    @State private var isAdditionButtonPressed = false
    @State private var isSubtractionButtonPressed = false
    
    var body: some View {
        NavigationStack {
            
            GeometryReader { geometry in
                ZStack {
                    PlainBackground()
                        .ignoresSafeArea(.all)
                       
                    BouncingOperationsLogo()
                        .offset(y: -0.40 * geometry.size.height)
                    
                    VStack(spacing: 25) {
                        
                        
                        
                        Button(action: {
                            withAnimation {
                                scene.state = .game
                                game.operation = .addition
                                game.isOperationSelected = true
                                isAdditionButtonPressed = true
                                if isSoundEnabled {
                                    SoundManager.instance.playSound(sound: .click)
                                }
                            }
                            heavyHaptic()
                        }) {
                            Text("+")
                                .font(.custom("RoundsBlack", size: 60))
                                .foregroundColor(Color("textColor"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
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
                                .scaleEffect(isAdditionButtonPressed ? 0.0 : 1.0)
                        }
                        
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
                                if isSoundEnabled {
                                    SoundManager.instance.playSound(sound: .click)
                                }
                            }
                            heavyHaptic()
                        }) {
                            Text("-")
                                .font(.custom("RoundsBlack", size: 60))
                                .foregroundColor(Color("textColor"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
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
                                .scaleEffect(isSubtractionButtonPressed ? 0.0 : 1.0)
                            
                        }
                        
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
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
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
                        
                        .disabled(true)
                        .opacity(0.5)
                        
                        Button("🔒") {
                            heavyHaptic()
                        }
                        .font(.custom("RoundsBlack", size: 55))
                        .foregroundColor(Color("textColor"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
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
                        
                        .disabled(true)
                        .opacity(0.5)
                        .frame(height: 0.1 * UIScreen.main.bounds.height)
                    }
                    .offset(y: 25)
                    .padding(.horizontal, 80)
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                       
                            Button {
                                scene.state = .mainmenu
                                heavyHaptic()
                                if isSoundEnabled {
                                    SoundManager.instance.playSound(sound: .click)
                                }
                            } label: {
                                Image("BackButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 175, height: 175)
                                    .offset(x: -55, y: 35)
                                    .offset(y: colorScheme == .light ? 0 : -30)
                                    .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                            }
                            //.disabled(true)
                            //.allowsHitTesting(false)
                            .animation(nil)
                            
                        
                    }
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
