//
//  Game.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import Foundation


class Math: ObservableObject{
    @Published var isAnswerCorrect = false
     private(set) var correctAnswer = 0
    var choiceSet: Set<Int> = []
   @Published var choicearry : [Int] = [0,1,2,3,4]
     private(set) var firstNum = 0
     private(set) var secondNum = 0
     private(set) var difficulty = 150
     private(set) var score = 0
    @Published var timeRemaining = 15 //this is in seconds naturally

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
          
          if self.isAnswerCorrect == false {
              choicearry = []
              correctAnswer =  self.firstNum + self.secondNum
              self.firstNum = Int.random(in: 0...(difficulty/2))
              self.secondNum = Int.random(in: 0...(difficulty/2))
              while choiceSet.count < 4 {
                         let randomNumber = Int.random(in: 0...difficulty)
                         if randomNumber != correctAnswer {
                             choiceSet.insert(randomNumber)
                         }
                     }
              choiceSet.insert(correctAnswer)
              choicearry = Array(choiceSet)
              choicearry.shuffle()
          }
      }
  }

