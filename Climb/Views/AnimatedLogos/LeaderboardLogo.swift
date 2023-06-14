//
//  LeaderboardLogo.swift
//  Climb
//
//  Created by Hadi Chamas  on 6/9/23.
//

import SwiftUI

struct LeaderboardLogo: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    
    let logoImage = Image("Leaderboard")
    
    var body: some View {
        VStack {
            Spacer()
            
            logoImage
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
                .offset(y: colorScheme == .light ? 30 : -25)
                .offset(x:-20)
                .offset(y: isAnimating ? 7 : 0)
                .shadow(
                    color: Color.black.opacity(0.5),
                    radius: 8,
                    x: 0,
                    y: 0)
            
            Spacer()
        }
        .onAppear {
            animateLogo()
        }
    }
    
    func animateLogo() {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            isAnimating = true
        }
    }
}

struct LeaderboardLogo_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardLogo()
    }
}
