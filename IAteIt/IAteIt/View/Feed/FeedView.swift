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
                    ForEach(mealList, id: \.self) { meal in
                        VStack(spacing: 8) {
                            FeedHeaderView(meal: meal)
                                .padding(.horizontal, .paddingHorizontal)
                            NavigationLink(destination: MealDetailView(commentBar: CommentBar(), meal: Meal.meals[2])) {
                                TabView {
                                    ForEach(meal.plates, id: \.self) { plate in
                                        PhotoCardView(plate: plate)
                                            .padding(.horizontal, .paddingHorizontal)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(minHeight: 358)
                            .tabViewStyle(.page)
                            NavigationLink(destination: MealDetailView(commentBar: CommentBar(), meal: Meal.meals[2])) {
                                //위 링크랑 다르게, 비리얼처럼 댓글창에 포커싱되어서 넘어가는 건 어떨지 해서 분리
                                FeedFooterView(meal: meal)
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
                ProfilePhotoButtonView(profileInfo: tempFeedPhotoCardList[0])
            })
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
