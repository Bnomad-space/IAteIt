//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {
    var tempPlateList = TempPlateData().list
    var tempCommentList = TempCommentData().list
    
    let paddingLR: CGFloat = 16
    let photoCorner: CGFloat = 20
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    MealDetailTopView()
                    
                    TabView {
                        ForEach(tempPlateList, id: \.self) { plate in
                            PhotoCardView(plate: plate)
                        }
                    }
                    .frame(minHeight: 358)
                    .tabViewStyle(.page)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(tempCommentList, id: \.self) { comment in
                            CommentView(comment: comment)
                        }
                    }
                    .padding([.top], 24)
                }
            }
            AddCommentBarView()
                .padding([.bottom], 10)
        }
        .padding([.leading, .trailing], paddingLR)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
