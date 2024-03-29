//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @State private var isActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
        List {
            if let user = loginState.user {
                ProfileCellView(user: user)
                    .padding([.top, .bottom], 16)
                    .configSimpleListRow()
                if feedMeals.myMealHistory.count > 0 {
                    ForEach(feedMeals.myMealHistorySorted, id:\.key) { (date, meals) in
                        MealListView(date: date, meals: meals, user: user)
                            .environmentObject(loginState)
                            .environmentObject(feedMeals)
                            .environmentObject(cameraViewModel)
                    }
                    .configSimpleListRow()
                } else {
                    HStack {
                        Spacer()
                        EmptyMealView()
                            .padding(.top, 100)
                        Spacer()
                    }
                    .configSimpleListRow()
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination:
                        SettingView()
                            .environmentObject(loginState)
                            .environmentObject(feedMeals),
                    isActive: self.$isActive,
                    label: { Image(systemName: "gearshape") }
                )
                .isDetailLink(false)
           }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
