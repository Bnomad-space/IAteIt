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
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
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
    
    func cropAndSavePhoto() {
        let watermark = UIImage(named: "Sample_Coffee")
        let image = UIImage(data: self.picData)!
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let resize = imageHeight * 0.5
        let cropRect = CGRect(x: resize - imageWidth * 0.5, y: 0, width: imageWidth, height: imageWidth)
        guard let croppedCGImage = image.cgImage?.cropping(to: cropRect) else { return }
        let croppedUIImage = UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
        let newImage = croppedUIImage.overlayWith(image: watermark ?? UIImage())
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
        print("[Camera]: Photo's saved")
        self.isSaved = true
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
        self.session.stopRunning()
    }
    
//    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
//    }
//
//    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
//    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        self.picData = imageData
        
        

        self.isCameraBusy = false

        print("[CameraModel]: Capture routine's done")
    }
    
}

extension UIImage {
    // 워터마크 오버레이 헬퍼 함수
    func overlayWith(image: UIImage) -> UIImage {
        let newSize = CGSize(width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        image.draw(in: CGRect(origin: CGPoint(x: size.width - 800, y: size.height - 2400), size: image.size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
