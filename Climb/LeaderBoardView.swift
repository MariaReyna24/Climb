//
//  ContentView.swift
//  LeaderBoard
//
//  Created by Delon Devin Allen on 2/14/23.
//

import SwiftUI
import GameKit

struct Player: Hashable, Comparable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        return rhs.score > lhs.score
    }
    
    let id = UUID()
    let name: String
    let score: Int
}

struct LeaderBoardView: View {
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @State var playersList: [Player] = []
    var body: some View {
        NavigationStack{
            ZStack {
                Image("climbss")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    ScrollView {
                        ForEach(playersList, id: \.id) { player in
                                Text("\(String(player.name)) Score: \(player.score)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color("myColor"))
                                    .font(.system(size: 25))
                            
                        }
                    }
                }
                .onAppear() {
                    if !GKLocalPlayer.local.isAuthenticated {
                        game.authenticateUser()
                    } else if playersList.count == 0 {
                        Task{
                            loadLeaderboard()
                        }
                    }
                }
                
            }.navigationTitle("Leaderboard")
            
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button {
                            scene.state = .mainmenu
                        }label: {
                            Label("Back", systemImage: "chevron.backward")
                        }
                        
                        .font(.title2)
                        .foregroundColor(Color("myColor"))
                    }
                    
                }
        }
        
        
    }
    func loadLeaderboard() {
        playersList.removeAll()
        Task {
            var playersListTemp: [Player] = []
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [game.leaderboardIdentifier])
            if let leaderboard = leaderboards.filter({ $0.baseLeaderboardID == game.leaderboardIdentifier }).first {
                let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...10))
                if allPlayers.1.count > 0 {
                    for leaderboardEntry in allPlayers.1 {
                        playersListTemp.append(Player(name: leaderboardEntry.player.displayName, score:leaderboardEntry.score))
                        print(playersListTemp)
                        playersListTemp.sort {
                            $0.score < $1.score
                        }
                    }
                }
            }
            playersList = playersListTemp
        }
    }
}


struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView(scene: diffViews(), game: Math())
    }
}
