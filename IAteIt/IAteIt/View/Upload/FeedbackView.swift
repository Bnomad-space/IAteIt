//
//  FeedbackView.swift
//  IAteIt
//
//  Created by 유재훈 on 2023/03/29.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject var viewModel = CameraViewModel()
    var body: some View {
        VStack() {
            HStack() {
                Button(action: {}, label: {
                    Image(systemName: "multiply")
                        .frame(width: 40, height: 40)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                })
                
                Spacer()
                
                Text("I'm eating it.")
                    .frame(width: 240, height: 49, alignment: .center)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                
                Text("")
                    .frame(width: 40)
            }
            
            ZStack {
                viewModel.cameraPreview
                    .onAppear {
                        viewModel.configure()
                        
                    }
                    .padding(.bottom, 120)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {}, label: {
                            Capsule()
                                .overlay(
                                    HStack {
                                        Text("\(Image(systemName: "arrow.left"))  Retake")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.white)
                                    })
                                .frame(width: 140, height: 50)
                                .padding(.bottom, 85)
                                .foregroundColor(.gray)
                        })
                        .padding(.leading)
                        Spacer()
                        
                        Button(action: {}, label: {
                            Capsule()
                                .overlay(
                                    HStack {
                                        Text("Upload  \(Image(systemName: "arrow.right"))")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.white)
                                    })
                                .frame(width: 140, height: 50)
                                .foregroundColor(.black)
                                .padding(.bottom, 85)
                            
                            
                        })
                        .padding(.trailing)
                    }
                }
            }
        }
    }
    
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
