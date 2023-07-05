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
    @State private var isActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
        List {
            ProfileCellView()
                .padding([.top, .bottom], 16)
                .environmentObject(loginState)
                .listRowSeparator(.hidden)
            if feedMeals.myMealHistory.count > 0 {
                ForEach(feedMeals.myMealHistorySorted, id:\.key) { (date, meals) in
                    MealListView(date: date, meals: meals)
                        .environmentObject(loginState)
                        .environmentObject(feedMeals)
                }
                .configSimpleListRow()
            } else {
                HStack {
                    Spacer()
                    EmptyMealView()
                        .padding(.top, 100)
                    Spacer()
                }
                .listRowSeparator(.hidden)
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
