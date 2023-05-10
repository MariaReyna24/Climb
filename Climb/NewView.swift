//
//  NewView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/10/23.
//

import SwiftUI

struct NewView: View {
    @ObservedObject var scene = diffViews()
    var body: some View {
        switch scene.state{
        case .mainmenu:
            MainMenuView()
        case .game:
            ContentView()
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
