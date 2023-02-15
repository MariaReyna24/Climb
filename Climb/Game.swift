//
//  Game.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import Foundation


class Math: ObservableObject{
    @Published var timeRemaining = 15 //this is in seconds naturally
    @Published var isAnswerCorrect = false
    @Published var choicearry : [Int] = [0,1,2,3,4,5,6,7,8,9]
    private(set) var correctAnswer = 0
    private(set) var firstNum = 0
    private(set) var secondNum = 0
    private(set) var difficulty = 150
    private(set) var score = 0
    
    
    func answerCorreect(answer:Int) -> Bool{
        if answer == correctAnswer {
            self.score += 1
            self.timeRemaining += 5
            self.isAnswerCorrect = true
            return true
        }else{
            if self.score < 1{
                self.score = 0
            } else {
                self.score -= 1
            }
            self.isAnswerCorrect = false
            return false
        }
    }
    
    func generateAnswers(){
        self.firstNum = Int.random(in: 0...(difficulty/2))
        self.secondNum = Int.random(in: 0...(difficulty/2))
        var answerList = [Int]()
        correctAnswer =  self.firstNum + self.secondNum
        
        for _ in 0...9{
            answerList.append(Int.random(in: 0...difficulty))
        }
        answerList.append(correctAnswer)
        choicearry = answerList.shuffled()
    }
}
