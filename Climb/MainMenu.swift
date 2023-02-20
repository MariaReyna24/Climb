//
//  MainMenu.swift
//  Climb
//
//  Created by Hadi Chamas  on 2/14/23.
//
import SwiftUI

struct MainMenuView: View {
    @State private var username = "Hadi" // replace with user's actual name
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // handle setting button action
                        }) {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                                .padding()
                                .frame(height: -500)
                            Spacer()
                        }
                    }
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                    
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                    Text("Welcome, \(username)!")
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Rectangle())
                    Spacer()
                    Button(action: {
                        // handle "Continue" button action
                    }) {
                        Text("Continue")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        
                        
                    }
                    NavigationLink(destination: ContentView(), label: {
                        Text("New Game")
                        
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                    )
                    NavigationLink(destination: LeaderBoardView(), label: {
                        Text("Leaderboard")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                    )
                    Spacer()
                    Spacer()
                    
                }
                .background(Image("mainMenuBackground"))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
