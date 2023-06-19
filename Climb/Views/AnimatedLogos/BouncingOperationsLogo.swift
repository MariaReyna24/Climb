import SwiftUI

struct BouncingOperationsLogo: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    
    let logoImage = Image("Operations")
    
    var body: some View {
        VStack {
            Spacer()
            
            logoImage
                .resizable()
                .scaledToFill()
                .frame(width: 375, height: 100)
                .offset(y: colorScheme == .light ? -95 : -25)
                .offset(x:-12, y: 30)
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

struct BouncingOperationsLogo_Previews: PreviewProvider {
    static var previews: some View {
        BouncingOperationsLogo()
    }
}
