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
            
            Divider()
                .padding(.horizontal)
            
            Text("Uncomment out uikit overlay to test uikit imp")
                .padding()
                .font(.subheadline.weight(.medium))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.065))
        .overlay(DrawerContainerView(isActive: $isSwiftUIDrawerActive))
        // .overlay(DrawerViewRepresentable(isActive: $isUIKitDrawerActive).ignoresSafeArea())
        .ignoresSafeArea(.keyboard)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
