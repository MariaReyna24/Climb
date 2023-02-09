//
//  Add Button.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import Foundation

struct Add_Button: View {
    var num : Int
    @Binding var game : Math
    @State var isAnswerCorrect = false
    @State private var backgroundColor = Color.black
    var body: some View {
        
        Button {
            let isCorrect = game.answerCorreect(answer: num)
            if isCorrect == true{
                backgroundColor = Color.green
            }else{
                backgroundColor = Color.red
            }
            game.generateAnswers()
            
        } label: {
            Text("\(num)")
                .frame(width: 90,height:50)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
                .background(backgroundColor)
                .clipShape(Rectangle())
        }
        .disabled(game.timeRemaining == 0)
        
    }
    
}

struct Add_Button_Previews: PreviewProvider {
    static var previews: some View {
        Add_Button(num: 100, game: .constant(Math()))
    }
}
