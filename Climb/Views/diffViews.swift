//
//  Views.swift
//  Climb
//
//  Created by Maria Reyna  on 5/10/23.
//

import Foundation

class diffViews: ObservableObject{
    @Published var state = gameState.mainmenu
    
    enum gameState{
        case mainmenu
        case game
        case leaderboard
        case settings
        case OperationsView
        case pauseMenu
    }
}
