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
    @Published var backgroundColor = Color("myColor")
    @Published var timeRemaining = 20 //this is in seconds naturally
    @Published var isAnswerCorrect = false
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var choicearry : [Int] = [0,1,2,3,4,5,6,7,8,9]
    @Published var score = 0
    @Published var isPaused = false
    @Published var greenButtonCount = 0
    var correctAnsArry : [Int] = []
    private(set) var correctAnswer = 0
    private(set) var firstNum = 0
    private(set) var secondNum = 0
    private(set) var difficulty = 30
    var levelnum = 1
    var leaderboardIdentifier = "climb.Leaderboard"
   
    
    func answerCorreect(answer:Int) -> Bool {
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
    
    func generateAnswers() {
        self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
        self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
        var answerList = [Int]()
        correctAnswer = self.firstNum + self.secondNum
        
        // This while loop ensures that the generated correctAnswer is not already present in the choicearry or correctAnsArry arrays. It continues generating new random numbers for firstNum and secondNum until a unique correctAnswer is obtained.
        while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) {
            self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            correctAnswer = self.firstNum + self.secondNum
        }
        
        // Once we get a correctAnswer, it is appended to the correctAnsArry array
        correctAnsArry.append(correctAnswer)
        
        // The incorrectRange is defined as a range of numbers from half of the difficulty level to the full difficulty level. This range will be used to generate incorrect answer choices.
        let incorrectRange = (difficulty/3)...(difficulty)
        
        // The for loop runs 10 times, each time appending a randomly generated number from the incorrectRange to the answerList array. The numbers are chosen to be different from the correctAnsArry.
        for _ in 0...9 {
            var randomIncorrectAnswer: Int
            repeat {
                randomIncorrectAnswer = Int.random(in: incorrectRange, excluding: correctAnsArry)
            } while answerList.contains(randomIncorrectAnswer)
            answerList.append(randomIncorrectAnswer)
        }
        
        // create an array that holds all of the indexes for not correct answers
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
        generateAnswers()
    }
    
    func retryLevel() {
        self.score = 0
        timeRemaining = 20
        generateAnswers()
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
