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
                        AsyncImage(url: URL(string: userImage)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .layoutPriority(-1)
                        } placeholder: {
                            Color(UIColor.systemGray5)
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
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    if let location = meal.location {
                        Text("\(location) • \(meal.uploadDate.timeAgoDisplay())")
                            .foregroundColor(Color.black)
                            .font(.footnote)
                    } else {
                        Text(meal.uploadDate.timeAgoDisplay())
                            .foregroundColor(Color.black)
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
