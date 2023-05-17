//
//  UploadView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var loginState: LoginStateModel
    @ObservedObject var feedMeals: FeedMealModel
    @ObservedObject var viewModel = CameraViewModel()
    @ObservedObject var model = Camera()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    @State var currentTime = Date()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.stopCamera()
                    dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .frame(width: 40, height: 40)
                        .font(.headline)
                        .foregroundColor(.black)
                })
                
                Spacer()
                Text("I'm eating it.")
                    .frame(width: 240, height: 49, alignment: .center)
                    .font(.headline)
                
                Spacer()
                
                Text("")
                    .frame(width: 40)
            }
            
            ZStack {
                viewModel.cameraPreview
                    .onAppear {
                        viewModel.configure()
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                            timer in currentTime = Date()
                        }
                    }
                    .padding(.bottom, 120)
                    .overlay(
                        Capsule()
                            .foregroundColor(Color.black.opacity(0.6))
                            .frame(width: 60, height: 28)
                            .overlay(
                                Text("\(currentTime, formatter: CameraView.dateFormat)")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            )
                            .padding(EdgeInsets(top: -230, leading: 290, bottom: 0, trailing: 0)))
                
                
                
                if viewModel.isTaken {
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: viewModel.reTake, label: {
                                Capsule()
                                    .overlay(
                                        HStack {
                                            Text("\(Image(systemName: "arrow.left"))  Retake")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        })
                                    .frame(width: 140, height: 50)
                                    .foregroundColor(.gray)
                            })
                            .padding(.leading)
                            Spacer()
                            
                            Button(action: {
                                viewModel.upload()
                                Task {
                                    saveNewMeal()
                                }
                                dismiss()
                            }, label: {
                                Capsule()
                                    .overlay(
                                        HStack {
                                            Text("Upload  \(Image(systemName: "arrow.right"))")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        })
                                    .frame(width: 140, height: 50)
                                    .foregroundColor(.black)
                            })
                            .padding(.trailing)
                        }
                        .padding(.bottom, 85)
                    }
                    
                } else {
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
}

extension CameraView {
    func saveNewMeal() {
        guard let userId = loginState.user?.id,
              let image = viewModel.imageToBeUploaded
        else { return }
        
        var meal = Meal(userId: userId, uploadDate: Date(), plates: [])
        var plate = Plate(id: UUID().uuidString, mealId: "", imageUrl: "", uploadDate: Date())
        Task {
            let plateImageUrl = try await FirebaseConnector.shared.uploadPlateImage(plateId: plate.id, image: image)
            print(plateImageUrl)
            plate.imageUrl = plateImageUrl
            meal.plates.append(plate)
            feedMeals.mealList.insert(meal, at: 0)
            try await FirebaseConnector.shared.setNewMeal(meal: meal)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(loginState: LoginStateModel(), feedMeals: FeedMealModel())
    }
}
