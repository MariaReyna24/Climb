//
//  ContentView.swift
//  LeaderBoard
//
//  Created ON 2/14/23.
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
                    Group{
                    HStack{
                        Text("Name")
                            .frame(width: 100, alignment: .topLeading)
                        Text("Score")
                            .frame(width: 110, alignment: .topTrailing)
                    }
                        ScrollView {
                            ForEach(playersList, id: \.id) { player in
                                HStack{
                                    Text("\(String(player.name.prefix(12)))")
                                        .frame(width: 150, alignment: .topLeading)
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .padding(1)
                                    Text("\(player.score)")
                                        .frame(width: 50, alignment: .topTrailing)
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                        .padding(1)
                                }
                                }
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
                            $1.score < $0.score
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
