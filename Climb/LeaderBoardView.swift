//
//  ContentView.swift
//  LeaderBoard
//
//  Created by Delon Devin Allen on 2/14/23.
//

import SwiftUI

struct LeaderBoardView: View {
    var friends = ["Maria","Daniel","Delon","Hadi","Michael"]
    var highScores = [
        HighScore(place: 1, name: "Maria", points: "100"),
        HighScore(place: 2, name: "Daniel", points: "75"),
        HighScore(place: 3, name: "Delon", points: "50"),
        HighScore(place: 4, name: "Hadi", points: "25"),
        HighScore(place: 5, name: "Michael", points: "15")
    ]
    
    let highscore = ["100 Points","75 Points","50 Points","25 Points","15 Points" ]
    
    
    var body: some View {
        ZStack{
            VStack {
                    List{
                        Text("Leaderboard")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .frame(width: 350)
                        ForEach(highScores, id: \.place) { highScore in
                            HStack {
                                Text("\(highScore.place). \(highScore.name)")
                                Spacer()
                                Text("\(highScore.points) Points")
                            }
//                            .swipeActions(allowsFullSwipe: false) {
//                                Button() {
//                                    print("Friend list")
//                                } label: {
//                                    Label("Add", systemImage: "plus")
//
//                                }
//                                .tint(.green)
//
//                                Button(role: .destructive) {
//                                    print("Deleting conversation")
//                                } label: {
//                                    Label("Delete", systemImage: "trash.fill")
//                                }
//                            }
                        }
                    }.scrollContentBackground(.hidden)
                    
                    
                    
                    //                    Button(role: .destructive) {
                    //                        print("Deleting conversation")
                    //                    } label: {
                    //                        Label("Delete", systemImage: "trash.fill")
                    //                    }
            }
        }.background(Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(width: 393, height: 918))
            
            
        
    }
    
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
