//
//  DrawerViewRepresentable.swift
//  test
//
//  Created by Sidney Sadel on 5/6/23.
//

import SwiftUI
import UIKit

struct DrawerViewRepresentable: UIViewControllerRepresentable {
    @Binding var isActive: Bool

    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = DrawerViewController(isActive: $isActive)
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, DrawerViewDelegate {
        func hide() {
            //
        }
        func show() {
            //
        }
    }
    
}
