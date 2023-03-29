//
//  Camera.swift
//  IAteIt
//
//  Created by 유재훈 on 2023/03/01.
//

import SwiftUI
import AVFoundation

class Camera: NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    
    @Published var isCameraBusy = false
    
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do {
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning()
            } catch {
                print(error)
            }
        }
    }
    
    func requestAndCheckPermissions() {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            
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
            
            setUpCamera()
        default:
            
            print("Permession declined")
        }
    }
    
    func capturePhoto() {

        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.photoQualityPrioritization = .quality
        
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }
    
    func cropAndSavePhoto(_ imageData: Data) -> UIImage {
        guard let image = UIImage(data: imageData) else { return UIImage() }
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let resize = imageHeight * 0.5
        let cropRect = CGRect(x: resize - imageWidth * 0.5, y: 0, width: imageWidth, height: imageWidth)
        guard let croppedCGImage = image.cgImage?.cropping(to: cropRect) else { return UIImage() }
        let croppedUIImage = UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
        return croppedUIImage
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
    }
    
//    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
//    }
//
//    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
//    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let image = self.cropAndSavePhoto(imageData)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.isCameraBusy = false
        print("이미지가 저장되었습니다.")
        print("[CameraModel]: Capture routine's done")
    }
    
}
