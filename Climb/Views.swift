//
//  Views.swift
//  Climb
//
//  Created by Maria Reyna  on 5/10/23.
//

import Foundation

class diffViews: ObservableObject{
    @Published var state = gameState.mainmenu
    @Published var viewCounter = 0
    
    func nextView(){
        if viewCounter == 1{
            ContentView()
        }
    }
    
    enum gameState{
        case mainmenu
        case game
        case leaderboard
    }
}
