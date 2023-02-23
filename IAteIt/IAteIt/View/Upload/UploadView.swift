//
//  UploadView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct UploadView: View {
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        ZStack{
                            Circle()
                                .fill(Color.white)
                                .frame(width: 55.33, height: 55.33, alignment: .center)
                            Circle()
                                .stroke(Color.white,lineWidth: 4)
                                .frame(width: 72, height: 72, alignment: .center)
                        }
                        .padding(.leading,70)
                    })
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color.black)
                            .opacity(0.35)
                            .padding(.trailing)
                    })
                    
                }
                
            }
        }
        
    }
}


struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
