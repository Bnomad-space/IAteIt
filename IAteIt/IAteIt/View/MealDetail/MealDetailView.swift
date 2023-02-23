//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {
    var body: some View {
        
        VStack {
            
            Text("맥모닝")
                .font(.headline)
            
            Text("2 hours ago")
                .font(.footnote)
            
            ZStack {
                Image("Sample_McMorning")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 358, height: 358, alignment: .center)
                    .clipped()
                    .cornerRadius(20)
                
                VStack {
                    HStack {
                        Text("맥도날드")
                            .font(.footnote)
                        Spacer()
                        Text("07:40")
                            .font(.footnote)
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                    }
                    .padding()
                }
                
            }
            .frame(width: 358, height: 358)
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
