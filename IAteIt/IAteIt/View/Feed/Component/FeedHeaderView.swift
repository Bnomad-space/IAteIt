//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import SwiftUI

struct FeedHeaderView: View {
    let profilePicSize: CGFloat = 36
    
    var meal: Meal
    var userId: String
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 12) {
                if let indexOfUser = User.users.firstIndex(where: { $0.id == userId }) {
                    ZStack {
                        Rectangle()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: profilePicSize, height: profilePicSize)
                        if let image = User.users[indexOfUser].profileImageUrl {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .layoutPriority(-1)
                                .frame(width: profilePicSize, height: profilePicSize)
                        }
                    }
                    .clipped()
                    .cornerRadius(profilePicSize/2)
                    .padding([.top], 3)
                    
                    VStack(alignment: .leading) {
                        Text(User.users[indexOfUser].nickname)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                            if let location = meal.location {
                                Text("\(location) • \(meal.uploadDate.toTimeString())")
                                    .font(.footnote)
                            } else {
                                Text(meal.uploadDate.toTimeString())
                                    .font(.footnote)
                            }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct FeedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
