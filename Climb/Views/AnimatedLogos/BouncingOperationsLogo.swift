//
//  BouncingOperationsLogo.swift
//  Climb
//
//  Created by Hadi Chamas  on 6/9/23.
//

import SwiftUI

struct BouncingOperationsLogo: View {
    @State private var isAnimating = false
    
    let logoImage = Image("Operations")
    
    var body: some View {
        VStack {
            Spacer()
            
            logoImage
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 325)
                .offset(y: isAnimating ? 7 : 0)
                .offset(x:-16)
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

struct BouncingOperationsLogo_Previews: PreviewProvider {
    static var previews: some View {
        BouncingOperationsLogo()
    }
}
