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
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(
            DrawerContainerView(isActive: $isDrawerActive, isAnimating: $isAnimating)
        )
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
