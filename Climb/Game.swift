//
//  Game.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import Foundation
import SwiftUI

class Math: ObservableObject{
    @Published var counter = 0
    @Published var timeRemaining = 15 //this is in seconds naturally
    @Published var isAnswerCorrect = false
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var choicearry : [Int] = [0,1,2,3,4,5,6,7,8,9]
    @Published var score = 0
    @Published var isPaused = false
    @Published var greenButtonCount = 0
    //@Published var redButtonCount = 0
    var correctAnsArry : [Int] = []
    private(set) var correctAnswer = 0
    private(set) var firstNum = 0
    private(set) var secondNum = 0
    private(set) var difficulty = 40
    var levelnum = 1
    
   
    
    func answerCorreect(answer:Int) -> Bool{
        if answer == correctAnswer {
            self.score += 1
            self.timeRemaining += 2
            self.isAnswerCorrect = true
            correctAnsArry.append(correctAnswer)
            greenButtonCount += 1
            return true
        } else {
            if self.score < 1 {
                self.score = 0
            } else {
                self.score -= 1
            }
            self.isAnswerCorrect = false
            timeRemaining -= 1
           // redButtonCount += 1
            return false
        }
    }
    
    func generateAnswers(){
        
        self.firstNum = Int.random(in: 0...(difficulty/2),excluding: correctAnsArry)
        self.secondNum = Int.random(in: 0...(difficulty/2),excluding: correctAnsArry)
        var answerList = [Int]()
        correctAnswer =  self.firstNum + self.secondNum
        
        while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer){
            self.firstNum = Int.random(in: 0...(difficulty/2),excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(difficulty/2),excluding: correctAnsArry)
            correctAnswer =  self.firstNum + self.secondNum
        }
        correctAnsArry.append(correctAnswer)
        
        for _ in 0...9{
            answerList.append(Int.random(in: 0...difficulty, excluding: correctAnsArry))
        }
        
        // create an array that holds all of the indexes for not correct answers
        var incorrectAnswers : [Int] = []
        for index in 0...9{
            let currentChoice = choicearry[index]
            
            if correctAnsArry.contains(currentChoice) && !answerList.contains(currentChoice){
                answerList[index] = currentChoice
            }else{
                incorrectAnswers.append(index)
            }
        }
        
        // grab a random index from the array of wrong answer indexes
        if let randomIndex = incorrectAnswers.randomElement() {
            // set the new correct answer at that index
            answerList[randomIndex] = correctAnswer
        }
        choicearry = answerList
    }
    
    func newLevel(){
        correctAnsArry = []
        greenButtonCount = 0
        levelnum += 1
        difficulty += 60
        generateAnswers()
    }
    func retryLevel(){
        self.score = 0
        timeRemaining = 15
        generateAnswers()
        correctAnsArry = []
        difficulty = 40
        levelnum =  1
        greenButtonCount = 0
    }
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
        }
    }
    
    func setScoreLeaderboard() {
        Task{
            try await GKLeaderboard.submitScore(
                self.score,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [leaderboardIdentifier]
            )
        }
    }
    
   
    
}


extension Int {
    static func random(in range: ClosedRange<Self>, excluding numbers: [Int]) -> Int {
        var randomInt = Int.random(in: range)
        
        while numbers.contains(randomInt) {
            randomInt = Int.random(in: range)
        }
        
        return randomInt
    }
}
