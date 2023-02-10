//
//  endGameMenu.swift
//  Climb
//
//  Created by Maria Reyna  on 2/8/23.
//

import SwiftUI

struct End_Game_menu: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Text("Game Over!")
                    .foregroundColor(.red)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 200,height: 110)
                    .background(Rectangle().fill(Color.black))
                HStack(spacing: 0){
                    Button("Retry"){
                       
                    }
                    .foregroundColor(.white)
                    .frame(width: 105, height: 50)
                    .background(.black)
                    
                    Button("Menu"){
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 96, height: 50)
                    .background(.black)
                }
            }
        }
    }
}
struct End_Game_menu_Previews: PreviewProvider {
    static var previews: some View {
        End_Game_menu()
    }
}

