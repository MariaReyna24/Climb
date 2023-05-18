//
//  Add Button.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import Foundation

struct ClimbButton: View {
    var num : Int
    @ObservedObject var game : Math
    @State private var backgroundColor = Color("myColor")
    @State private var isDisabled = false
    var body: some View {
        Button {
            let isCorrect = game.answerCorreect(answer: num)
            if isCorrect == true{
                haptic(.success)
                backgroundColor = Color.green
                disableButton()
            }else{
                backgroundColor = Color.red
                haptic(.error)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    backgroundColor = Color("myColor")
                        }
            }
            if isCorrect == true{
                game.isAnswerCorrect = true
                game.generateAnswers()
                
            }else{
                game.isAnswerCorrect = false
            }
            
        } label: {
             Text("\(num)")
                .frame(width: 90,height:50)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("textColor"))
                .opacity(1.0)
                .background(
                    backgroundColor
                        .opacity(1.0)
                )
                .clipShape(Rectangle())
                .cornerRadius(10)
                .shadow(color: .gray, radius: 10)
                .controlSize(.large)
            
               
        }
        
        .disabled(game.timeRemaining == 0 || isDisabled)
        .opacity(game.timeRemaining == 0 ? 0.8 : 1.0)
        .onChange(of: game.timeRemaining) { newTime in
            if newTime == 0{
                backgroundColor = Color("myColor")
            }
        }
        .onChange(of: game.levelnum){ _ in
           backgroundColor = Color("myColor")
        }
    }
    func disableButton() {
           isDisabled = true
       }
    struct button_Previews: PreviewProvider {
        static var previews: some View {
            ClimbButton(num: 100, game: Math())
        }
    }
}
