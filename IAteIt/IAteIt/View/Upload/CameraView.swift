//
//  UploadView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @ObservedObject var viewModel = CameraViewModel()
    @ObservedObject var model = Camera()
    

    var body: some View {
        VStack {
            HStack {
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
                if viewModel.isTaken {
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: viewModel.reTake, label: {
                                Capsule()
                                    .overlay(
                                        HStack {
                                            Text("\(Image(systemName: "arrow.left"))  Retake")
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundColor(.white)
                                        })
                                    .frame(width: 140, height: 50)
                                    
                                    .foregroundColor(.gray)
                            })
                            .padding(.leading)
                            Spacer()
                            
                            Button(action: viewModel.upload, label: {
                                Capsule()
                                    .overlay(
                                        HStack {
                                            Text("Upload  \(Image(systemName: "arrow.right"))")
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundColor(.white)
                                        })
                                    .frame(width: 140, height: 50)
                                    .foregroundColor(.black)
                            })
                            .padding(.trailing)
                        }
                        .padding(.bottom, 85)
                    }
                    
                } else {
                    VStack {
                        Spacer()
                        
                        Button(action: {viewModel.capturePhoto()}, label: {
                            Circle()
                                .stroke(.black,lineWidth: 4)
                                .frame(width: 72, height: 72)
                                .padding(.bottom, 85)
                        })
                    }
                }
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
