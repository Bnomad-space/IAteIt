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
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    @State var currentTime = Date()
    
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
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                            timer in currentTime = Date()
                        }
                    }
                    .padding(.bottom, 120)
                    .overlay(
                        Capsule()
                            .foregroundColor(Color.gray.opacity(0.6))
                            .frame(width: 60, height: 28)
                            .overlay(
                                Text("\(currentTime, formatter: CameraView.dateFormat)")
                                    .font(.system(size: 13, weight: .regular))
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
