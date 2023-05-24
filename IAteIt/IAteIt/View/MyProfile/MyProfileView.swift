//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {

    var body: some View {
        GeometryReader { g in
            VStack {
                ProfileCellView()

//                MealListView()

                
                ScrollView {
                    VStack {
                        MealListView()
                    }
                    .frame(width: g.size.width - 5, height: g.size.height - 5, alignment: .center)
                }
                .navigationTitle("Profile")
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

    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
