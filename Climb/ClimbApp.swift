
//
//  ClimbApp.swift
//  Climb
//
//  Created by Maria Reyna  on 2/1/23.
//

import SwiftUI
import AVFoundation
@main
   
struct ClimbApp: App {
    init() {
            configureAudioSession()
        }
        
       
    var body: some Scene {
        WindowGroup {
           NewView(game: Math())
        }
    }

    private func configureAudioSession() {
           do {
               try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
               try AVAudioSession.sharedInstance().setActive(true)
           } catch {
               print("Failed to configure audio session: \(error)")
           }
       }
   }
