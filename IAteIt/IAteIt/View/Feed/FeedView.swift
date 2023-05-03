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

    var mealList = Meal.meals
    
    var body: some View {
        NavigationView() {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 27) {
                    NavigationLink(destination: CameraView()) {
                        AddMealView()
                            .padding([.top], 24)
                            .padding(.horizontal, .paddingHorizontal)
                    }
                    .buttonStyle(PlainButtonStyle()) //버튼스타일 메소드 삭제하려면 컴포넌트 자체에서 지정해주어야
                    ForEach(mealList, id: \.self) { eachMeal in
                        VStack(spacing: 8) {
                            FeedHeaderView(meal: eachMeal)
                                .padding(.horizontal, .paddingHorizontal)
                            NavigationLink(destination: MealDetailView(commentBar: CommentBar(), meal: eachMeal)) {
                                TabView {
                                    ForEach(eachMeal.plates, id: \.self) { plate in
                                        PhotoCardView(plate: plate)
                                            .padding(.horizontal, .paddingHorizontal)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(minHeight: 358)
                            .tabViewStyle(.page)
                            NavigationLink(destination: MealDetailView(commentBar: CommentBar(), meal: eachMeal)) {
                                //위 링크랑 다르게, 비리얼처럼 댓글창에 포커싱되어서 넘어가는 건 어떨지 해서 분리
                                FeedFooterView(meal: eachMeal)
                                    .padding(.horizontal, .paddingHorizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            
            .navigationBarItems(leading:
                                    FeedTitleView()
                .padding([.leading], UIScreen.main.bounds.size.width/2-50) //TODO: 정렬다시
            )
            .navigationBarItems(trailing: NavigationLink(destination: MyProfileView()) {
                ProfilePhotoButtonView(profileInfo: tempFeedPhotoCardList[0]) //TODO: 유저 이미지
            })
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
