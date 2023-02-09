//
//  Game.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import Foundation


struct Math{
     private(set) var correctAnswer = 0
     private(set) var choicearry : [Int] = [0,1,2,3,4]
     private(set) var firstNum = 0
     private(set) var secondNum = 0
     private(set) var difficulty = 150
     private(set) var score = 0
    var timeRemaining = 4 //this is in seconds naturally

    mutating func answerCorreect(answer:Int) -> Bool{
        if answer == correctAnswer {
            score += 1
            timeRemaining += 5
            return true
        }else{
            if score < 1{
                score = 0
            } else {
                score -= 1
            }
            return false
        }
    }
    mutating func generateAnswers(){
        firstNum = Int.random(in: 0...(difficulty/2))
        secondNum = Int.random(in: 0...(difficulty/2))
        var answerList = [Int]()
        correctAnswer =  firstNum + secondNum
        
        for _ in 0...2{
            answerList.append(Int.random(in: 0...difficulty))
        }
        answerList.append(correctAnswer)
        choicearry = answerList.shuffled()
    }
    
}

