//
//  SettingsView.swift
//  Climb
//
//  Created by Maria Reyna  on 5/11/23.
//


import SwiftUI
import AVKit
struct SettingsView: View {
    @ObservedObject var scene: diffViews
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultKeys.soundEnabled) private var isSoundEnabled: Bool = true
    var body: some View {
        NavigationStack{
            ZStack {
                Image("climbss")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.custom("RoundsBlack", size: 40))
                    .frame(maxWidth: .infinity, alignment: .top)
                    Form {
                        haptics
                        sound
                    }.scrollContentBackground(.hidden)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        scene.state = .mainmenu
                    }label: {
                        Label("Back", systemImage: "chevron.backward")
                    }
                    .font(.title2)
                    .foregroundColor(Color("myColor"))
                }
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
        SettingsView(scene: diffViews())
        SettingsView(scene: diffViews()).preferredColorScheme(.dark)
    }
}
