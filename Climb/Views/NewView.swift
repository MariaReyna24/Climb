//
//  NewView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/10/23.
//

import SwiftUI

struct NewView: View {
    @ObservedObject var scene = diffViews()
    @ObservedObject var game: Math
    @State private var showLevelCompleted = false
    var body: some View {
        switch scene.state {
        case .mainmenu:
            MainMenuView(scene: scene, game: game)
        case .game:
            ContentView(scene: scene, game: game)
        case .leaderboard:
            LeaderBoardView(scene: scene, game: game)
        case .settings:
            SettingsView(scene: scene, game: game)
        case .OperationsView:
            OperationsView(scene: scene, game: game)
        case .pauseMenu:
            Pause_menu(scene: scene, game: game)
        }
        
    }
    
}



struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView(game: Math())
    }
}
