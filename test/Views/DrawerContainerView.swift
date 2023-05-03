//
//  DrawerContainerView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct DrawerContainerView: View {
    
    @Binding var isActive:Bool
    
    @State private var verticalOffset:CGFloat = .zero
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
                .onTapGesture {
                    isActive = false
                }
                .opacity(isActive ? 1.0 : 0.0)
            if isActive {
                DrawerView()
                    .offset(y: verticalOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { v in
                                withAnimation {
                                    if v.translation.height > 0 {
                                        verticalOffset = v.translation.height
                                    }
                                }
                            }
                            .onEnded { v in
                                withAnimation {
                                    if v.translation.height > 100 || v.predictedEndTranslation.height > 100 {
                                        isActive = false
                                    } else {
                                        verticalOffset  = .zero
                                    }
                                }
                            }
                    )
                    .zIndex(1)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0), value: isActive)
        .onChange(of: isActive) { b in
            if !b {
                verticalOffset = .zero
            }
        }
        
    }
    
}

struct DrawerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContainerView(isActive: .constant(true))
    }
}
