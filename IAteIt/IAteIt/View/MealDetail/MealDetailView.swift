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
                    Text("맥모닝")
                        .font(.headline)
                        .padding(EdgeInsets(top: 8, leading: paddingLR, bottom: 1, trailing: paddingLR))
                    Text("2 hours ago")
                        .font(.footnote)
                        .padding([.bottom], 8)
                    
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
                    .padding(EdgeInsets(top: 24, leading: paddingLR, bottom: 0, trailing: paddingLR))
                }
            }
            AddCommentBarView()
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
