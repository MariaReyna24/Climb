//
//  MainMenu.swift
//  Climb
//
//  Created by Hadi Chamas  on 2/14/23.
//
import SwiftUI
struct MainMenuView: View {
    @State private var viewNumber: Int?
    var body: some View {
        ZStack {
            switch viewNumber {
            case nil:
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 150)
                        .shadow(color: .black, radius: 10)
                        .offset(y: -180)
                    
                    Button("New Game") {
                        viewNumber = 1
                    }
                    .padding()
                    .foregroundColor(Color("textColor"))
                    .background(Color("myColor"))
                    .cornerRadius(10)
                    
                    Button("Leaderboard") {
                        viewNumber = 2
                    }
                    .padding()
                    .foregroundColor(Color("textColor"))
                    .background(Color("myColor"))
                    .cornerRadius(10)
                }
            case 1:
                ContentView()
            case 2:
                LeaderBoardView()
            default:
                MainMenuView()
            }
        }
        .background(Image("mainMenuBackground")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(width: 393, height: 918))
        .background(Color("myColor"))
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
