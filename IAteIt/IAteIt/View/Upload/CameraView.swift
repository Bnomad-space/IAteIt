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
        ZStack {
            viewModel.cameraPreview.ignoresSafeArea()
                .onAppear {
                    viewModel.configure()
                }
            
            VStack {
                Spacer()
                
                Button(action: {viewModel.capturePhoto()}, label: {
                    ZStack{
                        Circle()
                            .fill(Color.white)
                            .frame(width: 55.33, height: 55.33)
                        Circle()
                            .stroke(.white,lineWidth: 4)
                            .frame(width: 72, height: 72)
                    }
                    .padding()
                })
            }
        }
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
