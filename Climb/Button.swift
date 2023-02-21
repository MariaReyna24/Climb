//
//  Add Button.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import Foundation

struct button: View {
    var num : Int
    @ObservedObject var game : Math
    @State private var backgroundColor = Color("myColor")
    var body: some View {
        
        Button {
            let isCorrect = game.answerCorreect(answer: num)
            if isCorrect == true{
                
                backgroundColor = Color.green
            }else{
                backgroundColor = Color.red
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    backgroundColor = Color("myColor")
                        }
            }
            if isCorrect == true{
                game.isAnswerCorrect = true
                
            }else{
                game.isAnswerCorrect = false
            }
            game.generateAnswers()
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
        }
        .disabled(game.timeRemaining == 0)
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
    
    struct button_Previews: PreviewProvider {
        static var previews: some View {
            button(num: 100, game: Math())
        }
    }
}
