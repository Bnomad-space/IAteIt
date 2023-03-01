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

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    let cameraPreview: AnyView
    
    @Published var isFlashOn = false
    
    func configure() {
        model.requestAndCheckPermissions()
    }
    
    func switchFlash() {
        isFlashOn.toggle()
    }
    
    func capturePhoto() {
        print("[CameraViewModel]: Photo captured!")
    }
    
    func changeCamera() {
        print("[CameraViewModel]: Camera changed!")
    }
    
    init() {
        model = Camera()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
    }
}

class Camera: ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    
    // 카메라 셋업 과정을 담당하는 함수, positio
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
            }
        }
    }
    
    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
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
