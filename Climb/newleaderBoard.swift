//
//  newleaderBoard.swift
//  Climb
//
//  Created by Maria Reyna  on 2/10/23.
//

import SwiftUI

struct newleaderBoard: View {
    var body: some View {
        VStack {
            List{
                Text("                      LeaderBoard")
                    .padding()
                
                HStack {
                    Text("1. Maria")
                    Spacer()
                    Text("1,000,000,000 Points")
                }
                
                HStack{
                    Text("2. Daniel")
                    Spacer()
                    Text("750,000 Points")
                }
                HStack{
                    Text("3. Delon")
                    Spacer()
                    Text("500.000 Points")
                    
                }
                HStack{
                    Text("4. Hadi")
                    Spacer()
                    Text("250.000 Points")
                }
                HStack{
                    Text("5. Michael")
                    Spacer()
                    Text("100.000 Points")
                }
            }
            
        }
    }
}

struct newleaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        newleaderBoard()
    }
}

