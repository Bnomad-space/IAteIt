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
    let hapticImpact = UIImpactFeedbackGenerator()
    let cameraPreview: AnyView
    private var subscriptions = Set<AnyCancellable>()
    var imageToBeUploaded: UIImage?
    
    enum types {
        case newMeal
        case addPlate
        
        func setButtonText() -> String {
            switch self {
            case .newMeal:
                return "Upload"
            case .addPlate:
                return "Add"
            }
        }
    }

    @Published var type = types.newMeal
    @Published var isTaken = false
    @Published var shutterEffect = false
    @Published var isSaved = false
    
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
            hapticImpact.impactOccurred()
            withAnimation(.easeInOut(duration: 0.1)) {
                shutterEffect = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.shutterEffect = false
                }
            }
            model.capturePhoto()
            print("[CameraViewModel]: Photo captured!")
        } else {
            print("[CameraViewModel]: Camera's busy.")
        }
        
        DispatchQueue.main.async {
            withAnimation{self.isTaken.toggle()}
        }
        
    }
    
    func reTake() {
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                
                self.isSaved = false
            }
        }
    }
    
    func upload() {
        guard let croppedImage = model.cropPictureSquare() else { return }
        imageToBeUploaded = croppedImage
        let _ = model.timestampOverlay(image: croppedImage)
    }
    
    func stopCamera() {
        model.session.stopRunning()
    }
    
    func reset() {
        isTaken = false
        imageToBeUploaded = nil
        configure()
    }
}
