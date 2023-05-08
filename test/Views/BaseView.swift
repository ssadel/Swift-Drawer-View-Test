//
//  BaseView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct BaseView: View {
    
    /// SWIFTUI
    @State private var isSwiftUIDrawerActive:Bool = false
    @State private var isAnimating:Bool = false
    
    /// UIKIT
    @State private var isUIKitDrawerActive:Bool = false
    
    var body: some View {
        
        VStack {
            HStack(spacing: 25) {
                Button {
                    isSwiftUIDrawerActive.toggle()
                } label: {
                    Text("SwiftUI")
                }
                .buttonStyle(.bordered)
                .disabled(isAnimating)
                
                Divider()
                    .frame(height: 60)
                
                Button {
                    isUIKitDrawerActive.toggle()
                } label: {
                    Text("UIKit")
                }
                .buttonStyle(.bordered)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.065))
        .overlay(DrawerContainerView(isActive: $isSwiftUIDrawerActive, isAnimating: $isAnimating))
        // .overlay(DrawerViewRepresentable(isActive: $isUIKitDrawerActive).ignoresSafeArea())
        .ignoresSafeArea(.keyboard)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
