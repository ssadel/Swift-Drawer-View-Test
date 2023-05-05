//
//  BaseView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct BaseView: View {
    
    @State private var isDrawerActive:Bool = false
    @State private var isAnimating:Bool = false
    
    var body: some View {
        
        VStack {
            Button {
                isDrawerActive.toggle()
            } label: {
                Text("Open Drawer")
            }
            .buttonStyle(.bordered)
            .disabled(isAnimating)
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
        .background(Color.orange.opacity(0.065))
        .overlay(DrawerContainerView(isActive: $isDrawerActive, isAnimating: $isAnimating).ignoresSafeArea(.keyboard)) // MARK: Drawer Here
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
