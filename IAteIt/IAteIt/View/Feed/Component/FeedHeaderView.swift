//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import SwiftUI

struct FeedHeaderView: View {
    @ObservedObject var feedMeals: FeedMealModel
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
                        CacheAsyncImage(url: URL(string: userImage)!) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .layoutPriority(-1)
                            case .failure(_):
                                Image(systemName: "exclamationmark.circle")
                                    .resizable()
                                    .frame(width: profilePicSize, height: profilePicSize)
                                    .foregroundColor(Color(UIColor.systemGray3))
                            case .empty:
                                Color(UIColor.systemGray6)
                            @unknown default:
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: profilePicSize, height: profilePicSize)
                                    .foregroundColor(Color(UIColor.systemGray3))
                            }
                        }
                        .frame(width: profilePicSize, height: profilePicSize)
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: profilePicSize, height: profilePicSize)
                            .foregroundColor(Color(UIColor.systemGray3))
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
