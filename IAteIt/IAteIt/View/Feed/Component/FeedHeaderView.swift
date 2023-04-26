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
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 12) {
                if let indexOfUser = User.users.firstIndex(where: { $0.id == meal.userId }) {
                    ZStack {
                        if let userImage = User.users[indexOfUser].profileImageUrl {
                        Rectangle()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: profilePicSize, height: profilePicSize)
                            AsyncImage(url: URL(string: userImage)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .layoutPriority(-1)
                                    .frame(width: profilePicSize, height: profilePicSize)
                            } placeholder: {
                                Color.gray
                            }
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: profilePicSize, height: profilePicSize)
                                .foregroundColor(.gray)
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
}

struct FeedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(loginUser: LoginUser(), signUpVM: SignUpViewModel())
    }
}
