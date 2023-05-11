//
//  Add Button.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import Foundation
//import AVFoundation

struct ClimbButton: View {
    var num : Int
    @ObservedObject var game : Math
    //let systemSoundID: SystemSoundID = 1016
    @State private var backgroundColor = Color("myColor")
    var body: some View {
        Button {
            let isCorrect = game.answerCorreect(answer: num)
            if isCorrect == true{
                let notificationFeedback = UINotificationFeedbackGenerator()
                notificationFeedback.notificationOccurred(.success)
              //  AudioServicesPlaySystemSound(systemSoundID)
                backgroundColor = Color.green
            }else{
                backgroundColor = Color.red
                let notificationFeedback = UINotificationFeedbackGenerator()
                    notificationFeedback.notificationOccurred(.error)
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
//            game.generateAnswers()
            
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
            ClimbButton(num: 100, game: Math())
        }
    }
}
