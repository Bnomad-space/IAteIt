//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {

    let paddingLR: CGFloat = 16
    let photoCorner: CGFloat = 20
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                Text("맥모닝")
                    .font(.headline)
                    .padding(EdgeInsets(top: 8, leading: paddingLR, bottom: 1, trailing: paddingLR))
                
                Text("2 hours ago")
                    .font(.footnote)
                    .padding([.bottom], 8)
                
                GeometryReader { metrics in
                    let photoWidth = metrics.size.width - paddingLR * 2
                    
                    ZStack {
                        Image("Sample_McMorning")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: photoWidth, height: photoWidth)
                            .clipped()
                            .cornerRadius(photoCorner)
                        
                        VStack {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: photoCorner)
                                        .frame(width: 88, height: 28)
                                        .opacity(0.6)
                                        
                                    HStack(alignment: .center) {
                                        Image(systemName: "location")
                                            .font(.footnote)
                                        Text("맥도날드")
                                            .font(.footnote)
                                    }
                                    .foregroundColor(.white)
                                }
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: photoCorner)
                                        .frame(width: 80, height: 28)
                                        .opacity(0.6)
                                    
                                    HStack {
                                        Image(systemName: "clock")
                                            .font(.footnote)
                                        Text("07:40")
                                            .font(.footnote)
                                    }
                                    .foregroundColor(.white)
                                }
                            }
                            .padding()
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                            }
                            .padding()
                        }
                        
                    }
                    .padding([.leading, .trailing], paddingLR)
                }
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
