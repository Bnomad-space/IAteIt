//
//  ReportView.swift
//  IAteIt
//
//  Created by Beone on 2023/07/05.
//

import SwiftUI

struct ReportView: View {
    var meal: Meal
    var reason = ""
    @EnvironmentObject var loginState: LoginStateModel
    @Binding var isReportPresented: Bool
    @State private var text: String = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isReportPresented = false
                }, label: {
                    Text("취소")
                        .foregroundColor(.blue)
                })
                .padding()
                Spacer()
            }
            Spacer()
            Text("신고하겠습니다")
            TextField("Enter text", text: $text)
                            .frame(height: 100)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                FirebaseConnector().sendReport(reporterId: loginState.user?.id ?? "", reportedTime: Date(), mealId: meal.id ?? "", reason: text)
                isReportPresented = false
            }, label: {
                Label("신고하기", systemImage: "trash")
            })
            Spacer()
        }
    }
}
