//
//  View+Extension.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/14.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
    
    func configSimpleListRow() -> some View {
        self
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
    
    func innerShadow(cornerRadius: CGFloat, shadowRadius: CGFloat) -> some View {
        modifier(InnerShadowModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}

// MARK: - PinchZoom
struct PinchZoom<Content: View>: View {
    
    @State var scale: CGFloat = 0
    @State var offset: CGPoint = .zero
    @State var scalePosition: CGPoint = .zero
    
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .offset(x: offset.x, y: offset.y)
            .overlay(
                GeometryReader { proxy in
                    let size = proxy.size
                    ZoomGesture(size: size, scale: $scale, offset: $offset, scalePosition: $scalePosition)
                }
            )
            .scaleEffect(1 + scale, anchor: .init(x: scalePosition.x, y: scalePosition.y))
    }
}

struct ZoomGesture: UIViewRepresentable {
    
    var size: CGSize
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    @Binding var scalePosition: CGPoint
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        let Pinchgesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        view.addGestureRecognizer(Pinchgesture)
        
        let Pangesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))
        
        Pangesture.delegate = context.coordinator
        
        view.addGestureRecognizer(Pinchgesture)
        view.addGestureRecognizer(Pangesture)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var parent: ZoomGesture
        
        init(parent: ZoomGesture) {
            self.parent = parent
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc func handlePan(sender: UIPanGestureRecognizer) {
            
            sender.maximumNumberOfTouches = 2
            
            if (sender.state == .began || sender.state == .changed) {
                print(parent.scale)
                if let view = sender.view {
                    let translate = sender.translation(in: view)
                    
                    parent.offset = translate
                }
            } else {
                withAnimation {
                    parent.offset = .zero
                    parent.scalePosition = .zero
                }
            }
        }
        
        @objc func handlePinch(sender: UIPinchGestureRecognizer) {
            if sender.state == .began || sender.state == .changed {
                parent.scale = sender.scale - 1
                
                let scalePosition = CGPoint(x: sender.location(in: sender.view).x / sender.view!.frame.size.width, y: sender.location(in: sender.view).y / sender.view!.frame.size.height)
                parent.scalePosition = parent.scalePosition == .zero ? scalePosition : parent.scalePosition
            } else {
                withAnimation {
                    parent.scale = 0
                    parent.scalePosition = .zero
                }
            }
        }
    }
    
}

extension View {
    func pinchZoom() -> some View {
        return PinchZoom {
            self
        }
    }
}
