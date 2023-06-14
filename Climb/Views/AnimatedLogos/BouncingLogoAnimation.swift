import SwiftUI

struct BouncingLogoAnimation: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    
    let logoImage = Image("logo")
    
    var body: some View {
        VStack {
            Spacer()
            
            logoImage
                 .resizable()
                .scaledToFill()
                .frame(width: 100, height: 600)
                .offset(y: colorScheme == .light ? -310 : -190)
                .shadow(color: colorScheme == .light ? .black : .white, radius: 0, x: 0, y: 0)
                .offset(y: isAnimating ? 8 : 0)
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

struct BouncingLogoAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BouncingLogoAnimation()
    }
}
