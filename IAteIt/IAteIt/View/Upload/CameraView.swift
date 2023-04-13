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
    
    @State var currentTime = Date()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "multiply")
                        .frame(width: 40, height: 40)
                        .font(.headline)
                        .foregroundColor(.black)
                })
                
                Spacer()
                Text("I'm eating it.")
                    .frame(width: 240, height: 49, alignment: .center)
                    .font(.headline)
                
                Spacer()
                
                Text("")
                    .frame(width: 40)
            }
            
            ZStack {
                viewModel.cameraPreview
                    .onAppear {
                        viewModel.configure()
                        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {
                            timer in currentTime = Date()
                        }
                    }
                    .padding(.bottom, 120)
                    .overlay(
                        Capsule()
                            .foregroundColor(Color.black.opacity(0.6))
                            .frame(width: 60, height: 28)
                            .overlay(
                                Text("\(currentTime.toTimeString())")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            )
                            .padding(EdgeInsets(top: -230, leading: 290, bottom: 0, trailing: 0)))
                
                if viewModel.isTaken {
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: viewModel.reTake, label: {
                                Capsule()
                                    .overlay(
                                        HStack {
                                            Text("\(Image(systemName: "arrow.left"))  Retake")
                                                .font(.title3)
                                                .fontWeight(.semibold)
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
                                                .font(.title3)
                                                .fontWeight(.semibold)
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
