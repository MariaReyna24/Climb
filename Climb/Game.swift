//
//  Game.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//
import Foundation
import GameKit
import SwiftUI

class Math: ObservableObject{
    @Published var questionCounter = 0
    @Published var isGameCenterAuthenticated = false
    @Published var isShowingPauseMenu = false // Added state
    @Published var isOperationSelected = false
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
    var correctAnsArry : [Int] = []
    private(set) var correctAnswer = 0
    private(set) var firstNum = 0
    private(set) var secondNum = 0
    private(set) var difficulty = 32
    var levelnum = 1
    var leaderboardIdentifierAdd = "climb.Leaderboard"
    var leaderboardIdentiferSub = "climbSubtraction.Leaderboard"
    var leaderboardIdentiferMulti =  "Climb.multi"
    var leaderboardIdentiferDiv = "div.leaderboard"
    
    enum Operation {
        case addition
        case subtraction
        case multi
        case div
    }
    
    func answerCorreect(answer:Int) -> Bool {
        if answer == correctAnswer {
            self.score += 1
            questionCounter += 1
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
    
    func generateAnswers() {
        switch operation {
        case .addition:
            additionLogic()
        case .subtraction:
            subtractionLogic()
        case .multi:
            multiLogic()
        case .div:
            divLogic()
        }
    }
    
    func additionLogic(){
        self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
        self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
        
        correctAnswer = self.firstNum + self.secondNum
        
        while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) {
            self.firstNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(difficulty/2), excluding: correctAnsArry)
            correctAnswer = self.firstNum + self.secondNum
        }
        correctAnsArry.append(correctAnswer)
        
        incorrectAns()
    }
    
    func subtractionLogic(){
        let maxAttempts = 100 // Maximum number of attempts to find a valid subtraction question
        var attemptCount = 0
        var questionSkipped = false
        
        repeat {
            self.firstNum = Int.random(in: 0...difficulty, excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...difficulty/2, excluding: correctAnsArry)
            
            correctAnswer = self.firstNum - self.secondNum
            
            attemptCount += 1
            
        } while (firstNum < secondNum || choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer)) && attemptCount < maxAttempts
        
        if attemptCount >= maxAttempts {
            // Handle the case where a valid subtraction question couldn't be generated within the maximum attempts
            print("Unable to generate a valid subtraction question.")
            
            // Take appropriate action in your game logic (e.g., show an error message, skip the question, etc.)
            questionSkipped = true
        }
        
        if !questionSkipped {
            correctAnsArry.append(correctAnswer)
            incorrectAns()
        }
        
    }
    
    func multiLogic(){
        self.firstNum = Int.random(in: 0...(difficulty/3), excluding: correctAnsArry)
        self.secondNum = Int.random(in: 0...(difficulty/3), excluding: correctAnsArry)
        
        correctAnswer = self.firstNum * self.secondNum
        
        while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) {
            self.firstNum = Int.random(in: 0...(difficulty/3), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(difficulty/3), excluding: correctAnsArry)
            correctAnswer = self.firstNum * self.secondNum
        }
        correctAnsArry.append(correctAnswer)
        incorrectAns()
    }
    
    func divLogic(){
        let maxAttempts = 10 // Maximum number of attempts to find a valid division question
        var attemptCount = 0
        var questionSkipped = false
        
        repeat {
            let twoNums = isDivisible()
            
            self.firstNum = twoNums.1
            self.secondNum = twoNums.0
            
            correctAnswer = divideNumbers(twoNums)
            attemptCount += 1
            
        } while (choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer)) && attemptCount < maxAttempts
        
        if attemptCount >= maxAttempts {
            // Handle the case where a valid division question couldn't be generated within the maximum attempts
            
            print("Unable to generate a valid subtraction question.")
            self.firstNum = 4
            self.secondNum = 2
            
            correctAnswer = self.firstNum / self.secondNum
            
            correctAnsArry.append(correctAnswer)
            incorrectAns()
           
            
            questionSkipped = true
        }
        
        if !questionSkipped {
            correctAnsArry.append(correctAnswer)
            incorrectAns()
        }
    }
    
    func incorrectAns(){
        var answerList = [Int]()
        let upperBound = correctAnswer + max(difficulty/2, 10) // Adjust the maximum range based on your needs
        let incorrectRange = max(correctAnswer - 4, 0)...upperBound
        
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
    
    func isDivisible() -> (Int,Int) {
        let x = Int.random(in: 1...difficulty/3, excluding: correctAnsArry)
        let y = Int.random(in: 1...difficulty/3, excluding: correctAnsArry)
        let z = x * y
        return (x, z)
    }
    
    func divideNumbers(_ numbers: (Int, Int)) -> Int {
        let (x, y) = numbers
        return y / x
    }
    
    
    func endGame(){
        self.score = 0
        timeRemaining = 20
        correctAnsArry = []
        difficulty = 30
        levelnum =  1
        greenButtonCount = 0
        questionCounter = 0
        
    }
    
    func newLevel() {
        correctAnsArry = []
        greenButtonCount = 0
        levelnum += 1
        difficulty += 10
        generateAnswers()
        questionCounter = 0
    }
    
    func retryLevel() {
        self.score = 0
        timeRemaining = 20
        correctAnsArry = []
        levelnum = 1
        greenButtonCount = 0
        questionCounter = 0
    }
    
    
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] viewController, error in
            if GKLocalPlayer.local.isAuthenticated {
                self.isGameCenterAuthenticated = true
            } else {
                self.isGameCenterAuthenticated = false
            }
        }
    }
    
    func leaderboard() {
        let leaderboardIdentifier: String
        switch operation {
        case .addition:
            leaderboardIdentifier = leaderboardIdentifierAdd
        case .subtraction:
            leaderboardIdentifier = leaderboardIdentiferSub
        case .multi:
            leaderboardIdentifier = leaderboardIdentiferMulti
        case .div:
            leaderboardIdentifier = leaderboardIdentiferDiv
        }
        
        Task {
            let identifier = leaderboardIdentifier
            try await GKLeaderboard.submitScore(
                score,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [identifier]
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
