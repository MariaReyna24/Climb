//
//  levelCompleted.swift
//  Climb
//
//  Created by Maria Reyna  on 2/20/23.
//

import SwiftUI
struct levelCompleted: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @Environment(\.dismiss) var dismiss
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    @State private var showLevelCompleted = false
    @State private var isBoxFallen = false
    
    var body: some View {
        
        ZStack {
            
            
            VStack(spacing: 0){
                Text("Level Completed!")
                    .font(.custom("RoundsBlack", size: 25))
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .padding()
                    .scaleEffect(showLevelCompleted ? 1.0 : 0.0)
                    .opacity(showLevelCompleted ? 1.0 : 0.0)
                    .onAppear {
                        if isSoundEnabled {
                            SoundManager.instance.playSound(sound: .win)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                                showLevelCompleted = true
                            }
                        }
                    }
                
                Button("Continue") {
                    game.newLevel()
                    dismiss()
                    game.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    heavyHaptic()
                    game.isLevelComplete = false
                    if isSoundEnabled {
                        SoundManager.instance.playSound(sound: .click)
                    }
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                .opacity(0.9)
                .font(.custom("RoundsBlack", size: 25))
                
                Button("Main Menu") {
                    scene.state = .mainmenu
                    game.leaderboard()
                    game.endGame()
                    heavyHaptic()
                    game.isLevelComplete = false
                    if isSoundEnabled {
                        SoundManager.instance.playSound(sound: .click)
                    }
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                .opacity(0.9)
                .padding()
                .font(.custom("RoundsBlack", size: 25))
            }
            
            
        }
        
        .background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
        .frame(width: 300, height: 300)
        .foregroundColor(.black)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6))  {
                isBoxFallen = true
            }
        }
        .offset(y: isBoxFallen ? 0 : -500)
    }
}
    

struct levelCompleted_Previews: PreviewProvider {
    static var previews: some View {
        levelCompleted(scene: diffViews(), game: Math())
    }
}
