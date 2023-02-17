//
//  Pause Menu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI
import UIKit

struct Pause_menu: View {
    @State private var game = Math()
    var body: some View {
        ZStack{
            Color.black.opacity(0.7)
            Button("Pause"){
            }
        }
    }
}
struct Pause_menu_Previews: PreviewProvider {
    static var previews: some View {
        Pause_menu()
    }
}
