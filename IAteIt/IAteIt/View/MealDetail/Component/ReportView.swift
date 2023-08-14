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
                
                TextField("Please provide the reason for reporting.", text: $text)
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
                                            
                                            isAlertPresented = true
                                        }, label: {
                                            Image(systemName: "paperplane.fill")
                                                .foregroundColor(.black)
                                        })
                                )
            .alert("Submit Report", isPresented: $isAlertPresented, actions: {
                Button("Cancel", role: .cancel, action: {
                })
                Button("Submit", role: .destructive, action: {
                    FirebaseConnector().sendReport(reporterId: loginState.user?.id ?? "", reportedTime: Date(), mealId: meal.id ?? "", reason: text)
                    isReportPresented = false
                })
            }, message: {
                Text("Are you sure you want to submit this report?")
            })
        }
    }
}
