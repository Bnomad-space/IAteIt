//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import SwiftUI
import Kingfisher

struct FeedHeaderView: View {
    @ObservedObject var feedMeals: FeedMealModel
    @State private var error: KingfisherError?
    
    let profilePicSize: CGFloat = 36
    
    var meal: Meal
    var user: User
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    if let userImage = user.profileImageUrl {
                        Rectangle()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: profilePicSize, height: profilePicSize)
                            .foregroundColor(.white)
                        KFImage.url(URL(string: userImage)!)
                            .resizable()
                            .onFailure { error in
                                self.error = error
                            }
                            .placeholder {
                                ProfileImageErrorView(error: $error, size: profilePicSize)
                            }
                            .cancelOnDisappear(true)
                            .scaledToFill()
                            .layoutPriority(-1)
                            .frame(width: profilePicSize, height: profilePicSize)
                    } else {
                        ProfileImageDefaultView(size: profilePicSize)
                    }
                }
                .clipped()
                .cornerRadius(profilePicSize/2)
                .padding([.top], 3)
                
                VStack(alignment: .leading) {
                    Text(user.nickname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    if let location = meal.location {
                        Text("\(location) • \(meal.uploadDate.timeAgoDisplay())")
                            .font(.footnote)
                    } else {
                        Text(meal.uploadDate.timeAgoDisplay())
                            .font(.footnote)
                    }
                }
                Spacer()
            }
        }
    }
}

struct FeedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(cameraViewModel: CameraViewModel(), isActive: .constant(false))
    }
}
