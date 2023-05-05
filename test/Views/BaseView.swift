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
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<10) { _ in
                        Text("scroll for buttery smooth animations")
                            .padding()
                    }
                }
            }
            .frame(height: 100)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(DrawerContainerView(isActive: $isDrawerActive, isAnimating: $isAnimating)) // MARK: Drawer Here
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
