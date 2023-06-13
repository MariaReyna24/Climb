import SwiftUI

struct OperationsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    
    @State private var isAdditionButtonPressed = false
    @State private var isSubtractionButtonPressed = false
    
    var isSmallDevice: Bool {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let screenSize = min(screenWidth, screenHeight)
        
        // Adjust the threshold as per your requirements
        let smallDeviceThreshold: CGFloat = 320
        let currentDevice = UIDevice.current.model
        
        return screenSize <= smallDeviceThreshold && currentDevice != "iPhone13,4" // Exclude iPhone 13 Pro Max as a small device
    }
    
    var buttonYOffsetSmall: CGFloat {
        return isSmallDevice ? 50 : 80
    }
    
    var buttonYOffsetBig: CGFloat {
        return isSmallDevice ? 50 : -50 // Adjust the value as per your requirements
    }
    
    var logoYOffsetSmall: CGFloat {
        return isSmallDevice ? 10 : 25
    }
    
    var logoYOffsetBig: CGFloat {
        return isSmallDevice ? 10 : -60 // Adjust the value as per your requirements
    }
    
    var isBigDevice: Bool {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let screenSize = max(screenWidth, screenHeight)
        
        // Adjust the threshold as per your requirements
        let bigDeviceThreshold: CGFloat = 500
        
        return screenSize >= bigDeviceThreshold
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    ZStack {
                        PlainBackground()
                            .ignoresSafeArea()
                    }
                    
                    VStack(spacing: isSmallDevice ? 10 : 30) {
                        GeometryReader { imageGeometry in
                            BouncingOperationsLogo()
                                .padding(.horizontal, 20)
                                .frame(width: imageGeometry.size.width, height: imageGeometry.size.height)
                                .offset(y: colorScheme == .light ? -0 : 70)
                                .offset(y: isBigDevice ? logoYOffsetBig : logoYOffsetSmall)
                                .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                        }
                        .padding(.bottom, 10)
                        
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
                                .offset(x: -5, y: isBigDevice ? buttonYOffsetBig : buttonYOffsetSmall)
                                .padding(.horizontal)
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
                                .offset(x: -5, y: isBigDevice ? buttonYOffsetBig : buttonYOffsetSmall)
                                .padding(.horizontal)
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
                        .offset(x: -5, y: isBigDevice ? buttonYOffsetBig : buttonYOffsetSmall)
                        .padding(.horizontal)
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
                        .offset(x: -5, y: isBigDevice ? buttonYOffsetBig : buttonYOffsetSmall)
                        .padding(.horizontal)
                        .disabled(true)
                        .opacity(0.5)
                    }
                    .offset(y: isSmallDevice ? -100 : -150)
                    .padding(.horizontal, 70)
                }
                
                // ...
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        scene.state = .mainmenu
                        heavyHaptic()
                    } label: {
                        Image("BackButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isSmallDevice ? 50 : 165, height: isSmallDevice ? 50 : 165) // Adjust the size as needed
                            .offset(x: isSmallDevice ? -30 : -60, y: isSmallDevice ? 10 : 25) // Adjust the offset as needed
                            .offset(y: colorScheme == .light ? 0 : -30)
                            .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                    }
                    .disabled(true)
                    .allowsHitTesting(false)
                    .animation(nil)
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
