//
//  HapticManager.swift
//  test
//
//  Created by Sidney Sadel on 5/7/23.
//

import UIKit

class HapticManager {
    
    static let instance = HapticManager()
    
    func notification(type:UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style:UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}
