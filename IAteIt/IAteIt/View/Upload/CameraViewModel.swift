//
//  CameraViewModel.swift
//  IAteIt
//
//  Created by 유재훈 on 2023/03/01.
//

import SwiftUI
import AVFoundation
import Combine

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    private var isCameraBusy = false
    let cameraPreview: AnyView
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        model = Camera()
        session = model.session
        
        let screenSize = UIScreen.main.bounds.size
        let length: CGFloat = min(screenSize.width - 16, screenSize.height)
        cameraPreview = AnyView(CameraPreviewView(session: session)
            .frame(width: length, height: length))
        
        model.$isCameraBusy.sink { [weak self] (result) in
            self?.isCameraBusy = result
        }
        .store(in: &self.subscriptions)
    }
    
    func configure() {
        model.requestAndCheckPermissions()
    }
    
    func capturePhoto() {
        if isCameraBusy == false {
            model.capturePhoto()
            print("[CameraViewModel]: Photo captured!")
        } else {
            print("[CameraViewModel]: Camera's busy.")
        }
    }
}
