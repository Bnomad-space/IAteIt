//
//  AddFeedView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct AddMealView: View {
    @State var commentInput: String = ""
    
    let paddingLR: CGFloat = 16
    
    var body: some View {
        ZStack {
            Button(action: {
                // TODO: 끼니 추가 액션
            }, label: {
                Image(systemName: "camera")
                    .tint(.black)
                    .font(.body)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 50)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.10), radius: 20, x: 4, y: 4)
                .padding([.leading, .trailing], paddingLR)
            })
            HStack {
                TextField("What are you eating now?", text: $commentInput)
                    .font(.body)
                Spacer()
                
            }
            .padding([.leading, .trailing], 34)
        }
        
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView()
    }
}

