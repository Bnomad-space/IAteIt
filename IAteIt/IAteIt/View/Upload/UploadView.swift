//
//  UploadView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI
import AVFoundation

struct UploadView: View {
    @ObservedObject var viewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            viewModel.cameraPreview.ignoresSafeArea()
                .onAppear {
                    viewModel.configure()
                }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {viewModel.switchFlash()}, label: {
                        Image(systemName: viewModel.isFlashOn ? "bolt" : "bolt.fill")
                            .resizable()
                            .frame(width: 23, height: 37)
                            .foregroundColor(.white)
                        
                            .padding(.trailing,20)
                    })
                }
                Spacer()
                
                HStack {
                    Button(action: {}, label: {
                        ZStack{
                            Circle()
                                .fill(Color.red)
                                .frame(width: 55.33, height: 55.33)
                            Circle()
                                .stroke(Color.white,lineWidth: 4)
                                .frame(width: 72, height: 72)
                        }
                        .opacity(0)
                        .padding(.leading)
                    })
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
                    Spacer()
                    
                    Button(action: {viewModel.changeCamera()}, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.white)
                            .opacity(0.35)
                            .padding(.trailing,20)
                    })
                    
                }
                
            }
        }
        
    }
}


struct CameraPreviewView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        
        view.videoPreviewLayer.session = session
        view.backgroundColor = .black
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}


struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
