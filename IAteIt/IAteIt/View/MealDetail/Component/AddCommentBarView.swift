//
//  AddCommentBarView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/24.
//

import SwiftUI

struct AddCommentBarView: View {
    @State var commentInput: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 43)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.10), radius: 20, x: 4, y: 4)
                    
                HStack {
                    TextField("Add a comment...", text: $commentInput)
                        .font(.body)
                    Spacer()
                    Button(action: {
                        // TODO: 코멘트 추가 액션
                    }, label: {
                        Image(systemName: "paperplane")
                            .tint(.black)
                            .font(.body)
                    })
                }
                .padding([.leading, .trailing], 18)
            }
        }
    }
}

struct AddCommentBarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentBarView()
    }
}
