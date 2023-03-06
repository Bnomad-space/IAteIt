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
        cameraPreview = AnyView(CameraPreviewView(session: session))
    }
    
    func configure() {
        model.requestAndCheckPermissions()
    }
    
    func capturePhoto() {
        print("[CameraViewModel]: Photo captured!")
    }
    
}
