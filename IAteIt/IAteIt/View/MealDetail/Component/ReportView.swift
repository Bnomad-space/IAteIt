//
//  ReportView.swift
//  IAteIt
//
//  Created by Beone on 2023/07/05.
//

import SwiftUI

struct ReportView: View {
    let photoCorner: CGFloat = 20
    let iconSize: CGFloat = 48
    var meal: Meal
    var user: User
    var reason = ""
    @EnvironmentObject var loginState: LoginStateModel
    @Binding var isReportPresented: Bool
    @State private var isAlertPresented: Bool = false
    @State private var text: String = ""

    var body: some View {
        NavigationView{
            VStack {
                
                Text("\(user.nickname)'s meal")
                    .fontWeight(.semibold)
                    .padding(20)
                
                ZStack {
                    Rectangle()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(photoCorner)
                        .foregroundColor(.white)
                    
                    if let url = URL(string: meal.plates[0].imageUrl) {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .layoutPriority(-1)
                                    .cornerRadius(photoCorner)
                            case .failure(_):
                                PlateImageErrorView(iconSize: iconSize)
                            case .empty:
                                Color(UIColor.systemGray6)
                            @unknown default:
                                PlateImageErrorView(iconSize: iconSize)
                            }
                        }
                    }
                }
                .frame(height: 100)
                .clipped()
                .cornerRadius(photoCorner)
                
                TextField("Please tell us why you are reporting this meal.", text: $text)
                    .frame(height: 100)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
                Spacer()
            }
            .navigationBarTitle("Report", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                                        isReportPresented = false
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.black)
                                    }),
                                    trailing:
                                        Button(action: {
                                            FirebaseConnector().sendReport(reporterId: loginState.user?.id ?? "", reportedTime: Date(), mealId: meal.id ?? "", reason: text)
                                            isAlertPresented = true
                                        }, label: {
                                            Image(systemName: "paperplane.fill")
                                                .foregroundColor(.black)
                                        })
                                )
            .alert("Report Completed", isPresented: $isAlertPresented, actions: {
                Button("OK", role: .cancel, action: {
                    isReportPresented = false
                })
            }, message: {
                Text("Your report has been submitted successfully.")
            })
        }
    }
}
