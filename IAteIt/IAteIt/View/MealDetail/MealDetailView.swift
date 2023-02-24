//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {
    @State var tagLocation: String = "맥도날드"
    @State var tagTime: String = "07:40"
    
    var tempCommentList = TempCommentData().list
    
    let paddingLR: CGFloat = 16
    let photoCorner: CGFloat = 20
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("맥모닝")
                    .font(.headline)
                    .padding(EdgeInsets(top: 8, leading: paddingLR, bottom: 1, trailing: paddingLR))
                
                Text("2 hours ago")
                    .font(.footnote)
                    .padding([.bottom], 8)
                
                PhotoCardView(tagLocation: $tagLocation, tagTime: $tagTime)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(tempCommentList, id: \.self) { comment in
                        CommentView(comment: comment)
                    }
                    
                }
                .padding(EdgeInsets(top: 24, leading: paddingLR, bottom: 0, trailing: paddingLR))
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
