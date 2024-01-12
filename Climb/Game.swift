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
    // @Published var currentGameState: GameMode = GameMode.adding
    @Published var randOp: Operation = Operation.addition // for frenzy mode
    @Published var questionCounter = 0
    @Published var isGameCenterAuthenticated = false
    @Published var isShowingPauseMenu = false // keeps track of if pause menu is up
    @Published var isOperationSelected = false // keeps track of if operation is selected
    @Published var operation: Operation = .addition // keeps track of current operation
    @Published var isGameMenuShowing =  false
    @Published var isLevelComplete =  false
    @Published var backgroundColor = Color("myColor")
    @Published var timeRemaining = 20 //this is in seconds naturally
    @Published var isAnswerCorrect = false //keeps track of if the answer is correct
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // timer for the game
    @Published var choicearry : [Int] = [0,1,2,3,4,5,6,7,8,9]
    @Published var score = 0
    @Published var isPaused = false
    @Published var greenButtonCount = 0
    var correctAnsArry : [Int] = []
    private(set) var correctAnswer = 0
    private(set) var firstNum = 0
    private(set) var secondNum = 0
    private(set) var sharedDifficultyforAddSub = 16
    private(set) var sharedDifficultyforMultDiv = 10
    var levelnum = 1
    var leaderboardIdentifierAdd = "climb.Leaderboard"
    var leaderboardIdentiferSub = "climbSubtraction.Leaderboard"
    var leaderboardIdentiferMulti =  "Climb.multi"
    var leaderboardIdentiferDiv = "div.leaderboard"
    var leaderboardIdentifierRand = "randomLeaderboard"
    
    //    enum GameMode: CaseIterable {
    //        case adding
    //        case subtracting
    //        case multiplying
    //        case dividing
    //        case frenzy
    //    }
    
    
    enum Operation: CaseIterable {
        case addition
        case subtraction
        case multi
        case div
        var symbol: String {
            switch self {
            case .addition:
                return "+"
            case .subtraction:
                return "-"
            case .multi:
                return "*"
            case .div:
                return "/"
                //here i need to figure out how to get the right symbol to return using the cases
            }
        }
    }
    
    
    //this func generates the correct answer
    func answerCorreect(answer:Int) -> Bool {
        if answer == correctAnswer {
            //increases the score by 1
            self.score += 1
            //increases the question counter for going to next level
            questionCounter += 1
            //this is increasing or decreasing the time based on if you get the question right or wrong
            //time will not go above 30 secs tho
            if self.timeRemaining <= 28 {
                self.timeRemaining += 2
            }else{
                self.timeRemaining += 0
            }
            // this marks that this is the correct answer
            self.isAnswerCorrect = true
            //the correct answer is stored in an array to keep track of correct answers
            // so they dont appear
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
    
    
   // this function will generate the answers based on the operation that is selected
    func generateAnswers() {
        //            switch GameMode {
        //            case .adding:
        //                additionLogic()
        //            case .subtracting:
        //                subtractionLogic()
        //            case .dividing:
        //                divLogic()
        //            case .frenzy:
        //                frenzyLogic()
        //            }
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
    //addition logic
    func additionLogic(){
        self.firstNum = Int.random(in: 0...(sharedDifficultyforAddSub), excluding: correctAnsArry)
        self.secondNum = Int.random(in: 0...(sharedDifficultyforAddSub), excluding: correctAnsArry)
        
        correctAnswer = self.firstNum + self.secondNum
        
        while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) {
            self.firstNum = Int.random(in: 0...(sharedDifficultyforAddSub), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(sharedDifficultyforAddSub), excluding: correctAnsArry)
            correctAnswer = self.firstNum + self.secondNum
        }
        correctAnsArry.append(correctAnswer)
        
        var answerList = [Int]()
        //freezing might be here too
        let upperBound = correctAnswer + max(sharedDifficultyforAddSub, 22) // Adjust the maximum range based on your needs
        let incorrectRange = max(correctAnswer - 4, 0)...upperBound
        
        for _ in 0...9 {
            var randomIncorrectAnswer: Int
            repeat {
                //also still might be freezing here
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
        print(correctAnswer)
    }
    //this is the subtraction logic
    func subtractionLogic(){
        let maxAttempts = 100 // Maximum number of attempts to find a valid subtraction question
        var attemptCount = 0
        var questionSkipped = false
        
        repeat {
            self.firstNum = Int.random(in: 0...sharedDifficultyforAddSub, excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...sharedDifficultyforAddSub, excluding: correctAnsArry)
            
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
            var answerList = [Int]()
            //freezing might be here too
            let upperBound = correctAnswer + max(sharedDifficultyforAddSub, 22) // Adjust the maximum range based on your needs
            let incorrectRange = max(correctAnswer - 4, 0)...upperBound
            
            for _ in 0...9 {
                var randomIncorrectAnswer: Int
                repeat {
                    //also still might be freezing here
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
            print(correctAnswer)
        }
    }
    //this is the multiplcation logic
    func multiLogic(){
        self.firstNum = Int.random(in: 0...(sharedDifficultyforMultDiv), excluding: correctAnsArry)
        self.secondNum = Int.random(in: 0...(sharedDifficultyforMultDiv), excluding: correctAnsArry)
        
        correctAnswer = self.firstNum * self.secondNum
        
        while choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer) {
            self.firstNum = Int.random(in: 0...(sharedDifficultyforMultDiv), excluding: correctAnsArry)
            self.secondNum = Int.random(in: 0...(sharedDifficultyforMultDiv), excluding: correctAnsArry)
            correctAnswer = self.firstNum * self.secondNum
        }
        correctAnsArry.append(correctAnswer)
        var answerList = [Int]()
        //freezing might be here too
        let upperBound = correctAnswer + max(sharedDifficultyforMultDiv, 22) // Adjust the maximum range based on your needs
        let incorrectRange = max(correctAnswer - 4, 0)...upperBound
        
        for _ in 0...9 {
            var randomIncorrectAnswer: Int
            repeat {
                //also still might be freezing here
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
        print(correctAnswer)
    }
    // this is all the divison logic
    func divLogic(){
        let maxAttempts = 15 // Maximum number of attempts to find a valid division question
        var attemptCount = 0
        var questionSkipped = false
        
        repeat {
            let twoNums = isDivisible(operation: .div)
            
            self.firstNum = twoNums.1
            self.secondNum = twoNums.0
            
            correctAnswer = divideNumbers(twoNums)
            attemptCount += 1
            
        } while (choicearry.contains(correctAnswer) || correctAnsArry.contains(correctAnswer)) && attemptCount < maxAttempts
        
        if attemptCount >= maxAttempts {
            // Handle the case where a valid division question couldn't be generated within the maximum attempts
            
            print("Unable to generate a valid divison question.")
            
            self.firstNum = 4
            self.secondNum = 2
            
            correctAnswer = self.firstNum / self.secondNum
            
            correctAnsArry.append(correctAnswer)
            
            var answerList = [Int]()
            //freezing might be here too
            let upperBound = correctAnswer + max(sharedDifficultyforMultDiv, 18) // Adjust the maximum range based on your needs
            let incorrectRange = max(correctAnswer - 4, 0)...upperBound
            
            for _ in 0...9 {
                var randomIncorrectAnswer: Int
                repeat {
                    //also still might be freezing here
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
            choicearry = answerList
            questionSkipped = true
        }
        if !questionSkipped {
            correctAnsArry.append(correctAnswer)
            var answerList = [Int]()
            //freezing might be here too
            let upperBound = correctAnswer + max(sharedDifficultyforMultDiv, 22) // Adjust the maximum range based on your needs
            let incorrectRange = max(correctAnswer - 4, 0)...upperBound
            
            for _ in 0...9 {
                var randomIncorrectAnswer: Int
                repeat {
                    //also still might be freezing here
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
            print(correctAnswer)
        }
    }
    //this will return a random operation from the enum Operation
    func randomOperation() -> Operation {
        let newOp = Operation.allCases.dropLast()
        // print(newOp)
        if let newOperation = newOp.randomElement(){
            randOp = newOperation
        }
        return randOp
    }
    
    //this func decides what logic should be done based on the random operation that was choose in the randomOperation func
    func frenzyLogic(){
        operation = randomOperation()
        generateAnswers()
    }
    //in this func we multiply two numbers then we return the product and the second number.
    func isDivisible(operation: Operation) -> (Int,Int) {
        let x = Int.random(in: 1...sharedDifficultyforMultDiv, excluding: correctAnsArry)
        let y = Int.random(in: 1...sharedDifficultyforMultDiv, excluding: correctAnsArry)
        let z = x * y
        return (x, z)
    }
    //this is a function used to divide two numebers in a tuple
    func divideNumbers(_ numbers: (Int, Int)) -> Int {
        let (x, y) = numbers
        return y / x
    }
    // called when you end the game and return to the main menu
    //just sets everything back to normal
    func endGame(){
        self.score = 0
        timeRemaining = 20
        correctAnsArry = []
        levelnum =  1
        greenButtonCount = 0
        questionCounter = 0
        switch operation {
        case .addition:
            sharedDifficultyforAddSub = 14
        case .subtraction:
            sharedDifficultyforAddSub = 14
        case .multi:
            sharedDifficultyforMultDiv = 10
        case .div:
            sharedDifficultyforMultDiv = 10
        }
    }
    //a func for new levels called when you complete a level
    func newLevel() {
        correctAnsArry = []
        greenButtonCount = 0
        levelnum += 1
        questionCounter = 0
        switch operation {
        case .addition:
            sharedDifficultyforAddSub += 5
        case .subtraction:
            sharedDifficultyforAddSub += 5
        case .multi:
            sharedDifficultyforMultDiv += 3
        case .div:
            sharedDifficultyforMultDiv += 3
        }
        generateAnswers()
    }
    //used to retry the level when you run out of time
    func retryLevel() {
        self.score = 0
        timeRemaining = 20
        correctAnsArry = []
        levelnum = 1
        greenButtonCount = 0
        questionCounter = 0
        sharedDifficultyforAddSub = 14
        sharedDifficultyforMultDiv = 10
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
    //authenticates the user for GameCenter
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] viewController, error in
            if GKLocalPlayer.local.isAuthenticated {
                self.isGameCenterAuthenticated = true
            } else {
                self.isGameCenterAuthenticated = false
            }
        }
    }
    
    //used to change the leaderboard depending on what game mode you are in
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
            //        case .frenzy:
            //            leaderboardIdentifier = leaderboardIdentifierRand
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

//this is an extention of the built in Int data type
//it makes the random fucntion on a Int exclude numbers in a certain range
extension Int {
    static func random(in range: ClosedRange<Self>, excluding numbers: [Int]) -> Int {
        var randomInt = Int.random(in: range)
        var count = 0
        //might be freezing still here as well
        while numbers.contains(randomInt) || count < 9 {
            randomInt = Int.random(in: range)
            count += 1
        }
        return randomInt
        
    }
}
