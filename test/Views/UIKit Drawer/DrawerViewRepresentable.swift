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
        let vc = DrawerViewController(isActive: isActive)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        if isActive {
//            uiViewController.view.alpha = 1.0
//        } else {
//            uiViewController.view.alpha = 0.0
//        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: DrawerViewRepresentable
        
        init(_ parent: DrawerViewRepresentable) {
            self.parent = parent
        }
    }
}
