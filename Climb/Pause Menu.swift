//
//  Pause Menu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI

struct Pause_menu: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
            }
            .navigationTitle("Paused")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Back"){
                        
                    }
                }
            }
        }
    }
}
struct Pause_menu_Previews: PreviewProvider {
    static var previews: some View {
        Pause_menu()
    }
}
