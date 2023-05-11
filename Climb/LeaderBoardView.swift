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
    @StateObject var game = Math()
    @State var playersList: [Player] = []
    var leaderboardIdentifier = "climb.Leaderboard"
    var body: some View {
        ZStack{
            VStack {
                Text("Leaderboard")
                ScrollView{
                    ForEach(playersList, id: \.id) { player in
                        Text("\(String(player.name.prefix(8))) Score: \(player.score)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .textCase(.uppercase)
                    }
                }
            }
            .onAppear(){
                if !GKLocalPlayer.local.isAuthenticated {
                    game.authenticateUser()
                } else if playersList.count == 0 {
                    Task{
                        await loadLeaderboard()
                    }
                }
            }
            
        }.background(Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(width: 393, height: 918))
        
        
        
    }
    func loadLeaderboard() {
        playersList.removeAll()
        Task{
            var playersListTemp : [Player] = []
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
            if let leaderboard = leaderboards.filter ({ $0.baseLeaderboardID == self.leaderboardIdentifier }).first {
                let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...10))
                if allPlayers.1.count > 0 {
                    for leaderboardEntry in allPlayers.1 {
                        playersListTemp.append(Player(name: leaderboardEntry.player.displayName, score:leaderboardEntry.score))
                                    print(playersListTemp)

                    }
                }
            }
            playersList = playersListTemp
            playersList = playersList.sorted {
                $0.score < $1.score
            }
            playersList.reverse()
        }
    }
}


struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
