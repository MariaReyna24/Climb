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
    @Environment(\.colorScheme) var colorScheme
    @State private var isLeaderboardLoaded = false
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    @State var playersList: [Player] = []
    @State var leaderboardPlace = 0
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    PlainBackground()
                        .ignoresSafeArea(.all)
                    LeaderboardLogo()
                        .offset(y: -0.40 * geometry.size.height)
                        .offset(x: 0.02 * geometry.size.height)
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                withAnimation(nil){
                                    Button {
                                        scene.state = .mainmenu
                                        heavyHaptic()
                                        if isSoundEnabled {
                                            SoundManager.instance.playSound(sound: .click)
                                        }
                                    } label: {
                                        Image("BackButton")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 175, height: 175)
                                            .offset(x: -55, y: 35)
                                            .offset(y: colorScheme == .light ? 0 : -30)
                                            .shadow(color: colorScheme == .light ? .black : .white, radius: 3, x: 0, y: 0)
                                            .transaction { transaction in
                                                transaction.animation = nil
                                            }
                                    }
                                }
                            }
                        }
                }
                
                VStack {
                    Picker(selection: $game.currentGamemode, label: Text("Operation")) {
                        Text("Add").tag(Math.GameMode.add)
                        Text("Sub").tag(Math.GameMode.sub)
                        Text("Multi").tag(Math.GameMode.mul)
                        Text("Div").tag(Math.GameMode.divide)
                        Text("Frenzy").tag(Math.GameMode.frenzy)
                        
                    } 
                    .onChange(of: game.currentGamemode) { _ in
                        Task{
                         await loadLeaderboard()
                        }
                    }
                    .onChange(of: game.currentGamemode) { newValue in
                        if playersList.isEmpty && isLeaderboardLoaded {
                            Task{
                             await loadLeaderboard()
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    
                    ScrollView {
                        VStack() { // Add a spacing to separate the rows
                            HStack(spacing: 100) {
                                Text("Name")
                                    .frame(width: 100, alignment: .leading)
                                    .font(.custom("RoundsBlack", size: 20))
                                    .foregroundColor(.white)
                                
                                Text("Score")
                                    .frame(width: 90, alignment: .center)
                                    .font(.custom("RoundsBlack", size: 20))
                                    .foregroundColor(.white)
                            }
                            Divider()
                                .frame(height:5)
                                .overlay(
                                    Color.primary
                                        .opacity(0.5)
                                )
                                .padding(.vertical, 5) // Add some vertical padding
                            
                            ForEach(playersList, id: \.id) { player in
                                HStack(spacing: 74) {
                                    Text("\(String(player.name.prefix(11)))")
                                        .frame(width: 155, alignment: .leading)
                                        .foregroundColor(.white)
                                        .font(.custom("RoundsBlack", size: 18))
                                    
                                    Text("\(player.score)")
                                        .frame(width: 50, alignment: .leading)
                                        .foregroundColor(.white)
                                        .font(.custom("RoundsBlack", size: 24))
                                }
                                .padding(1)
                                
                                Color.primary
                                    .opacity(0.5)
                                    .frame(height: 5)
                            }
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                    }
                    .offset(y: 80) // Move the offset to the ScrollView
                }
                
                .onAppear() {
                    if !GKLocalPlayer.local.isAuthenticated {
                        game.authenticateUser()
                    } else if playersList.isEmpty && !isLeaderboardLoaded {
                        Task{
                         await loadLeaderboard()
                        }
                    }
                }
                
            }
            
            
        }
    }
    func loadLeaderboard() async {
        do {
            var playersListTemp: [Player] = []
            let leaderboardIdentifier: String
            
            switch game.currentGamemode {
            case .add:
                leaderboardIdentifier = game.leaderboardIdentifierAdd
            case .sub:
                leaderboardIdentifier = game.leaderboardIdentiferSub
            case .mul:
                leaderboardIdentifier = game.leaderboardIdentiferMulti
            case .divide:
                leaderboardIdentifier = game.leaderboardIdentiferDiv
            case .frenzy:
                leaderboardIdentifier = game.leaderboardIdentifierRand
            }
            
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
            
            if let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardIdentifier }) {
                let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...100))
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
        } catch {
            print("Error loading leaderboard: \(error)")
        }
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView(scene: diffViews(), game: Math())
    }
}
