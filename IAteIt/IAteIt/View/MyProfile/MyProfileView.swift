//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @State private var isActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
        GeometryReader { g in
            ScrollView {
                VStack {
                    ProfileCellView()
                    MealListView()
                }
                .frame(width: g.size.width - 5, height: g.size.height - 5, alignment: .center)
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: SettingView().environmentObject(loginState),
                        isActive: self.$isActive,
                        label: { Image(systemName: "gearshape") }
                    )
                    .isDetailLink(false)
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
