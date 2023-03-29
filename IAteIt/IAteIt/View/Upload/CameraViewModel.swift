//
//  CameraViewModel.swift
//  IAteIt
//
//  Created by 유재훈 on 2023/03/01.
//

import SwiftUI
import AVFoundation

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    let cameraPreview: AnyView
    
    init() {
        model = Camera()
        session = model.session
        
        let screenSize = UIScreen.main.bounds.size
        let length: CGFloat = min(screenSize.width - 16, screenSize.height)
        cameraPreview = AnyView(CameraPreviewView(session: session)
            .frame(width: length, height: length))
    }
    
    func configure() {
        model.requestAndCheckPermissions()
    }
    
    func capturePhoto() {
        model.capturePhoto()
        print("[CameraViewModel]: Photo captured!")
    }
    
}
