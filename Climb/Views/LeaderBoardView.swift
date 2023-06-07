//
//  ContentView.swift
//  LeaderBoard
//
//  Created on 2/14/23.
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
    @State private var isLeaderboardLoaded = false
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @State var playersList: [Player] = []
    @State var leaderboardPlace = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                PlainBackground()
                    .offset(y:-50)
                
                VStack {
                    Picker(selection: $game.operation, label: Text("Operation")) {
                        Text("Addition").tag(Math.Operation.addition)
                        Text("Subtraction").tag(Math.Operation.subtraction)
                    }
                    .onChange(of: game.operation) { _ in
                                    loadLeaderboard()
                                }
                    .onChange(of: game.operation) { newValue in
                        if playersList.isEmpty && isLeaderboardLoaded {
                            loadLeaderboard()
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(20)

                    Text("Leaderboard")
                        .font(.custom("RoundsBlack", size: 30))
                        .foregroundColor(.white)
                        .padding()
                        
                    HStack(spacing: 128){
                        Text("Name")
                            .frame(width: 75, alignment: .leading)
                            .font(.custom("RoundsBlack", size: 20))
                            .foregroundColor(.white)
                        
                        Text("Score")
                            .frame(width: 75, alignment: .center)
                            .font(.custom("RoundsBlack", size: 20))
                            .foregroundColor(.white)
                            
                    }
                   Divider()
                        .frame(height:5)
                        .overlay(
                                Color.primary
                                    .opacity(0.5)
                                )
                        ScrollView {
                            ForEach(playersList, id: \.id) { player in
                                HStack(spacing: 76){
                                    
                                    Text("\(String(player.name.prefix(12)))")
                                        .frame(width: 155, alignment: .leading)
                                        .foregroundColor(.white)
                                        .font(.custom("RoundsBlack", size: 18))
                
                                    Text("\(player.score)")
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(.white)
                                        .font(.custom("RoundsBlack", size: 24))
                                        
                                }
                                .padding(1)
                                Color.black

                           }
                    }
                }
                
                .onAppear() {
                           if !GKLocalPlayer.local.isAuthenticated {
                               game.authenticateUser()
                           } else if playersList.isEmpty && !isLeaderboardLoaded {
                               loadLeaderboard()
                           }
                       }
                
            }
            
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button {
                            scene.state = .mainmenu
                            heavyHaptic()
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
        Task {
            var playersListTemp: [Player] = []
            let leaderboardIdentifier: String

            switch game.operation {
            case .addition:
                leaderboardIdentifier = game.leaderboardIdentifierAdd
            case .subtraction:
                leaderboardIdentifier = game.leaderboardIdentiferSub
            }

            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])

            if let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardIdentifier }) {
                let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...10))
                if allPlayers.1.count > 0 {
                    for leaderboardEntry in allPlayers.1 {
                        playersListTemp.append(Player(name: leaderboardEntry.player.displayName, score: leaderboardEntry.score))
                    }
                    playersListTemp.sort {
                        $1.score < $0.score
                    }
                }
            }

            DispatchQueue.main.async {
                playersList = playersListTemp
                isLeaderboardLoaded = true
            }
        }
    }

}


struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView(scene: diffViews(), game: Math())
    }
}
