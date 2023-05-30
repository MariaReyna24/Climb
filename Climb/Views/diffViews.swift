//
//  Views.swift
//  Climb
//
//  Created by Maria Reyna  on 5/10/23.
//

import Foundation

class diffViews: ObservableObject{
    @Published var state = gameState.mainmenu
    @Published var selectedOperation: Math.Operation = .addition // Default operation
  
    enum gameState{
        case mainmenu
        case game
        case leaderboard
        case settings
    }
}
