//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var loginState: LoginStateModel

    var body: some View {
        ScrollView {
            VStack {
                ProfileCellView()
                MealListView()
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               NavigationLink(destination: {
                   SettingView()
               }, label: {
                   Image(systemName: "gearshape")
               })

            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
