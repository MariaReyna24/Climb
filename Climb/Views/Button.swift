//
//  Add Button.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import Foundation

struct ClimbButton: View {
    var num: Int
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    @State private var backgroundColor = Color("myColor")
    @State private var isDisabled = false
    
    
    var body: some View {
        Button {
            let isCorrect = game.answerCorreect(answer: num)
            if isCorrect {
                haptic(.success)
                backgroundColor = Color.green
                if isSoundEnabled{
                    SoundManager.instance.playSound(sound: .chime)
                }
                
            } else {
                backgroundColor = Color.red
                haptic(.error)
                if isSoundEnabled{
                    SoundManager.instance.playSound(sound: .wrong)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    backgroundColor = Color("myColor")
                }
            }
            if isCorrect {
                game.isAnswerCorrect = true
                game.generateAnswers(state: diffViews())
            } else {
                game.isAnswerCorrect = false
            }
        } label: {
            Text("\(num)")
                .frame(width: 88, height: 75)
                .font(.custom("RoundsBlack", size: 27))
                .foregroundColor(Color("textColor"))
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .fill(backgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(Color("WhiteDM"), lineWidth: 5) // Added white outline
                                .shadow(color: .black, radius: 5, x: 0, y: 0)
                        )
                        .padding(4)
                        .clipShape(RoundedRectangle(cornerRadius: 50)) // Aligned clip shape correctly
                )
                .shadow(color: .gray, radius: 10, x: 0, y: 2) // Added shadow behind the button
                .padding(0.5)
                .controlSize(.large)
        }


        .disabled(game.timeRemaining == 0 || isDisabled)
        .opacity(game.timeRemaining == 0 ? 0.8 : 1.0)
        .onChange(of: game.timeRemaining) { newTime in
            if newTime == 0 {
                backgroundColor = Color("myColor")
            }
        }
        .onChange(of: game.levelnum) { _ in
            backgroundColor = Color("myColor")
        }
        .onChange(of: game.operation) { _ in
            game.generateAnswers(state: diffViews())
        }
    }
    
   
    
    struct Button_Previews: PreviewProvider {
        static var previews: some View {
            ClimbButton(num: 100, game: Math())
        }
    }
}
