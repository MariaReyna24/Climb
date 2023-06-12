//
//  SettingsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/11/23.
//


import SwiftUI
import AVKit
struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var scene: diffViews
    @ObservedObject var game: Math
    @AppStorage(UserDefaultKeys.hapticsEnabled) var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) var isSoundEnabled: Bool = true
    var body: some View {
        NavigationStack{
            
    
            ZStack {
                            PlainBackground()
                                .offset(y:-50)
                
                Image("Settings")
                    .resizable()
                    .scaledToFit()
                   // .frame(width: 400, height: 300)
                    .offset(y: -200)
                    .offset(x: 25)
                    .offset(y: colorScheme == .light ? 5 : 85)
                    .shadow(color: colorScheme == .light ? .black : .white, radius: 5, x: 0, y: 0)
                
                
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button {
                                scene.state = .mainmenu
                                heavyHaptic()
                            }label: {
                                Image("BackButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height:200)
                                    .offset( x:-65, y: 45)
                                .offset(y: colorScheme == .light ? 5 : -35)
                                 .offset(x: colorScheme == .light ? -0: -0)
                                    .shadow(color: colorScheme == .light ? .black : .white, radius: 5, x: 0, y: 0)
                            }
                        }
                    }
            }
            
            
            
            VStack {
                
                
                Form {
                    haptics
                    sound
                }.scrollContentBackground(.hidden)
                    .offset(y:-300)
            }
            
        }
        
    }
}


private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
            .font(.custom("RoundsBlack", size: 20))
            .listRowBackground(Color("whiteOpacity"))
            .foregroundColor(Color.white)
        
    }
}

private extension SettingsView {
    var sound: some View {
        Toggle("Enable Sound", isOn: $isSoundEnabled)
            .font(.custom("RoundsBlack", size: 20))
            .listRowBackground(Color("whiteOpacity"))
            .foregroundColor(Color.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(scene: diffViews(), game: Math())
    }
}
