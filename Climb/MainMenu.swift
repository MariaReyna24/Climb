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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // handle setting button action
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .padding()
                            .frame(height:-500)
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
                Button(action: {
                    // handle "New Game" button action
                }) {
                    Text("New Game")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                Button(action: {
                    // handle "Leaderboard" button action
                }) {
                    Text("Leaderboard")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
