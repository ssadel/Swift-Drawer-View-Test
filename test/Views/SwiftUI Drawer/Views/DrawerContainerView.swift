//
//  DrawerContainerView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct DrawerContainerView: View {
    
    @Binding var isActive:Bool
    @Binding var isAnimating:Bool
    
    @StateObject var viewModel = DrawerViewModel()
    
    @State private var verticalOffset:CGFloat = .zero
    @State private var drawerHeight:CGFloat = .zero
    @GestureState private var isDragging:Bool = false
    @FocusState private var isFocused:Bool
    
    private let insertAnimationTime:Double = 0.275
    private let removalAnimationTime:Double = 0.15
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            background
                .opacity(isActive ? 1.0 : 0.0)
            
            if isActive {
                drawerView
            }
        }
        .animation(.interactiveSpring(response: 0.33, dampingFraction: 0.81, blendDuration: 0), value: isActive)
        .onChange(of: isActive) { b in
            verticalOffset = .zero
            if !b {
                viewModel.drawerRoute = .Base
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
    
    /// A semi-transparent background view that dismisses the drawer when tapped
    private var background: some View {
        Color.black
            .opacity(0.14)
            .ignoresSafeArea()
            .onTapGesture {
                if !isAnimating {
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)) {
                        self.dismissKeyboard()
                        verticalOffset += 100
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
                            isActive = false
                        }
                    }
                }
            }
    }
    
    /// The main drawer view that includes the gesture for dragging
    private var drawerView: some View {
        DrawerView(viewModel: viewModel, isDraggingDrawer: isDragging, isFocused: $isFocused)
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
                                    self.dismissKeyboard()
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
                                if viewModel.drawerRoute == .EditBio || viewModel.drawerRoute == .EditName {
                                    isFocused = true
                                }
                            }
                        }
                    }
            ) 
            .allowsHitTesting(!isDragging)
            .zIndex(1)
            .transition(.move(edge: .bottom))
            .offset(x: viewModel.shouldShakeDrawer ? -8 : 0)
            .animation(Animation.default.repeatCount(3, autoreverses: true).speed(6), value: viewModel.shouldShakeDrawer)
    }
    
}

struct DrawerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContainerView(isActive: .constant(true), isAnimating: .constant(false))
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
