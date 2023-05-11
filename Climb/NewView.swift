//
//  NewView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/10/23.
//

import SwiftUI

struct NewView: View {
    @ObservedObject var scene = diffViews()
    @State private var showLevelCompleted = false
    var body: some View {
        switch scene.state{
        case .mainmenu:
            MainMenuView(scene: scene)
        case .game:
            ContentView(scene: scene)
        case .leaderboard:
            LeaderBoardView()
        }
        
    }
    
}



struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
