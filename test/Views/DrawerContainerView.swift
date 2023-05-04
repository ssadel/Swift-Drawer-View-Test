//
//  DrawerContainerView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI
//
struct DrawerContainerView: View {
    
    @Binding var isActive:Bool
    @Binding var isAnimating:Bool
    
    @State private var verticalOffset:CGFloat = .zero
    @State private var drawerHeight:CGFloat = .zero
    @GestureState private var isDragging:Bool = false
    
    let insertAnimationTime:Double = 0.275
    let removalAnimationTime:Double = 0.15
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            background
                .opacity(isActive ? 1.0 : 0.0)
            
            if isActive {
                drawerView
            }
        }
        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0), value: isActive)
        .onChange(of: isActive) { b in
            verticalOffset = .zero
            if !b {
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now()+removalAnimationTime) {
                    isAnimating = false
                }
            } else {
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now()+insertAnimationTime) {
                    isAnimating = false
                }
            }
        }
        
    }
    
    var background: some View {
        Color.black
            .opacity(0.1)
            .ignoresSafeArea()
            .onTapGesture {
                if !isAnimating {
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)) {
                        verticalOffset += 100
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
                            isActive = false
                        }
                    }
                }
            }
    }
    
    var drawerView: some View {
        DrawerView(isDraggingDrawer: isDragging)
            .id("DrawerView")
            .onPreferenceChange(ViewHeightKey.self) { value in
                drawerHeight = value
            }
            .offset(y: verticalOffset)
            .simultaneousGesture(
                DragGesture()
                    .updating($isDragging, body: { value, state, transaction in
                        state = value.translation.height > 0
                    })
                    .onChanged { v in
                        withAnimation(.linear(duration: 0.2)) {
                            if !isAnimating {
                                if v.translation.height > 0 {
                                    verticalOffset = v.translation.height
                                } else if v.translation.height > -35 {
                                    verticalOffset = max(v.translation.height, -35)
                                }
                            }
                        }
                    }
                    .onEnded { v in
                        withAnimation {
                            if !isAnimating, v.translation.height > drawerHeight/1.3 || v.predictedEndTranslation.height > drawerHeight/1.3 {
                                isActive = false
                            } else {
                                verticalOffset  = .zero
                            }
                        }
                    }
            )
            .allowsHitTesting(!isDragging)
            .zIndex(2)
            .transition(.move(edge: .bottom))
    }
    
}

struct DrawerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContainerView(isActive: .constant(true), isAnimating: .constant(false))
    }
}
