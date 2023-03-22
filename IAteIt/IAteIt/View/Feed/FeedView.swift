//
//  FeedView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct FeedView: View {
    var tempFeedPhotoCardList = TempFeedPhotoCardData().list
    var tempPlateList = TempPlateData().list
    
    var body: some View {
            ScrollView {
                VStack{
                    
                    AddMealView()
                        .padding([.top], 24)
                        .padding([.bottom], 24)
                        .padding([.leading, .trailing], 16)
                    ForEach(tempFeedPhotoCardList, id: \.self) { postInfo in
                        FeedHeaderView(PostInfo: postInfo)
                            .padding([.bottom], 8)
                        TabView {
                            ForEach(tempPlateList, id: \.self) { plate in
                                PhotoCardView(plate: plate)
                            }
                        }
                        .frame(minHeight: 358)
                        .tabViewStyle(.page)
                        .padding([.bottom], 8)
                        FeedFooterView()
                            .padding([.bottom], 27)
                    }
                }
            }
            .navigationBarItems(leading:
                    FeedTitleView()
                    .padding([.leading], UIScreen.main.bounds.size.width/2-50) //TODO: 정렬다시
            )
            .navigationBarItems(trailing:
                                    ProfilePhotoButtonView(profileInfo: tempFeedPhotoCardList[0]) //TODO: 프로필사진 연결
            )
        }
        
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
