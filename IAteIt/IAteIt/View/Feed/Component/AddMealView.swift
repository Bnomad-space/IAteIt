//
//  AddFeedView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct AddMealView: View {
    
    var body: some View {
        ZStack {
            Button(action: {
                // TODO: 끼니 추가 액션
            }, label: {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.10), radius: 10, x: 4, y: 4)
            })
            HStack(spacing: 12) {
                Image(systemName: "camera")
                    .tint(.black)
                    .font(.body)
                Text("What are you eating now?")
                    .font(.subheadline)
                Spacer()
            }
            .padding([.leading], 22)
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView()
    }
}

