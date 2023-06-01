//
//  Game.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import Foundation
import SwiftUI
import GameKit

class Math: ObservableObject{
    @Published var operation: Operation = .addition
    @Published var isGameMenuShowing =  false
    @Published var isLevelComplete =  false
    @Published var backgroundColor = Color("myColor")
    @Published var timeRemaining = 20 //this is in seconds naturally
    @Published var isAnswerCorrect = false
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var choicearry : [Int] = [0,1,2,3,4,5,6,7,8,9]
    @Published var score = 0
    @Published var isPaused = false
    @Published var greenButtonCount = 0
    @Published var isOperationSelected = false
    var correctAnsArry : [Int] = []
    private(set) var correctAnswer = 0
    private(set) var firstNum = 0
    private(set) var secondNum = 0
    private(set) var difficulty = 30
    var levelnum = 1
    var leaderboardIdentifier = "climb.Leaderboard"
    
    enum Operation {
        case addition
        case subtraction
    }
    
    func answerCorreect(answer:Int) -> Bool {
        if answer == correctAnswer {
            self.score += 1
            if self.timeRemaining <= 28 {
                self.timeRemaining += 2
            }else{
                self.timeRemaining += 0
            }
            self.isAnswerCorrect = true
            correctAnsArry.append(correctAnswer)
            greenButtonCount += 1
            leaderboard() 
            return true
        } else {
            if self.score < 1 {
                self.score = 0
            } else {
                self.score -= 1
            }
            self.isAnswerCorrect = false
            timeRemaining -= 1
            return false
        }
       
    }
    
    func generateAnswers(state: diffViews) {
        var answerList = [Int]()
        switch operation {
        case .addition:
            self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            
            correctAnswer = self.firstNum + self.secondNum
            
            while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) {
                self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
                self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
                correctAnswer = self.firstNum + self.secondNum
            }
            correctAnsArry.append(correctAnswer)
            let incorrectRange = (difficulty/3)...(difficulty)
            for _ in 0...9 {
                var randomIncorrectAnswer: Int
                repeat {
                    randomIncorrectAnswer = Int.random(in: incorrectRange, excluding: correctAnsArry)
                } while answerList.contains(randomIncorrectAnswer)
                answerList.append(randomIncorrectAnswer)
            }
            var incorrectAnswers: [Int] = []
            for index in 0...9 {
                let currentChoice = choicearry[index]
                
                if correctAnsArry.contains(currentChoice) && !answerList.contains(currentChoice) {
                    answerList[index] = currentChoice
                } else {
                    incorrectAnswers.append(index)
                }
            }
            
            // grab a random index from the array of wrong answer indexes
            if let randomIndex = incorrectAnswers.randomElement() {
                // set the new correct answer at that index
                answerList[randomIndex] = correctAnswer
            }
            
            choicearry = answerList
            
        case .subtraction:
            self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)

            correctAnswer = self.firstNum - self.secondNum
            
            while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) || firstNum < secondNum {
                self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
                self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
                correctAnswer = self.firstNum - self.secondNum
            }
            correctAnsArry.append(correctAnswer)
            let incorrectRange = (difficulty/3)...(difficulty)
            for _ in 0...9 {
                var randomIncorrectAnswer: Int
                repeat {
                    randomIncorrectAnswer = Int.random(in: incorrectRange, excluding: correctAnsArry)
                } while answerList.contains(randomIncorrectAnswer)
                answerList.append(randomIncorrectAnswer)
            }
            var incorrectAnswers: [Int] = []
            for index in 0...9 {
                let currentChoice = choicearry[index]
                
                if correctAnsArry.contains(currentChoice) && !answerList.contains(currentChoice) {
                    answerList[index] = currentChoice
                } else {
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
      
    }
    
    func endGame(){
        self.score = 0
        timeRemaining = 20
        correctAnsArry = []
        difficulty = 30
        levelnum =  1
        greenButtonCount = 0
    }
    
    func newLevel() {
        correctAnsArry = []
        greenButtonCount = 0
        levelnum += 1
        difficulty += 10
        generateAnswers(state: diffViews())
    }
    
    func retryLevel() {
        self.score = 0
        timeRemaining = 20
        generateAnswers(state: diffViews())
        correctAnsArry = []
        difficulty = 30
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
            
    func leaderboard(){
        Task{
             try await GKLeaderboard.submitScore(
                score,
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
