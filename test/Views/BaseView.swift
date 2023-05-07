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
            
            VStack(alignment: .leading) {
                Text("Current Drawer Routes")
                    .font(.subheadline.weight(.medium))
                Text("- Edit Name")
                    .font(.subheadline.weight(.regular))
                Text("- Account")
                    .font(.subheadline.weight(.regular))
            }
            
            ScrollView(.horizontal) {
                HStack {
                    Image(systemName: "arrow.left")
                    ForEach(0..<10) { _ in
                        Text("scroll for buttery smooth animations")
                            .padding(.horizontal)
                    }
                    Image(systemName: "arrow.right")
                }
                .padding()
            }
            .frame(height: 100)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.065))
        .overlay(DrawerContainerView(isActive: $isSwiftUIDrawerActive, isAnimating: $isAnimating))
        //.overlay(DrawerViewRepresentable(isActive: $isUIKitDrawerActive))
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
