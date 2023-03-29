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
    
    var body: some View {
        VStack() {
            HStack() {
                Button(action: {}, label: {
                    Image(systemName: "multiply")
                        .frame(width: 75, height: 40, alignment: .leading)
                        .padding(.leading)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                })
                Text("I'm eating it.")
                    .frame(width: 240, height: 49)
                    .font(.system(size: 20, weight: .semibold))
                
                
                Spacer()
                
            }
            ZStack {
                viewModel.cameraPreview
                    .onAppear {
                        viewModel.configure()
                        
                    }
                    .padding(.bottom, 120)
                
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

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
