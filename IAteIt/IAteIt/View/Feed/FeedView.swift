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
    
    var mealList = Meal.meals
    
    let paddingLR: CGFloat = 16
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 27) {
                    AddMealView()
                        .padding([.top], 24)
                        .padding(.horizontal, paddingLR)
                    ForEach(mealList, id: \.self) { meal in
                        VStack(spacing: 8) {
                            FeedHeaderView(meal: meal)
                                .padding(.horizontal, paddingLR)
                            TabView {
                                ForEach(meal.plates, id: \.self) { plate in
                                    PhotoCardView(plate: plate)
                                        .padding(.horizontal, paddingLR)
                                }
                            }
                            .frame(minHeight: 358)
                            .tabViewStyle(.page)
                            FeedFooterView(meal: meal)
                                .padding(.horizontal, paddingLR)
                        }
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
