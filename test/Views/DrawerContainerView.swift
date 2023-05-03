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
    
    @State private var verticalOffset:CGFloat = .zero
    @State private var didScrollDownABitFirst:Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
                .onTapGesture {
                    // TODO: fix top of drawer still being visible here (swiftui bug)
                    if !isAnimating {
                        isActive = false
                    }
                }
                .opacity(isActive ? 1.0 : 0.0)
            if isActive {
                DrawerView()
                    .offset(y: verticalOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { v in
                                withAnimation(.default) {
                                    if !isAnimating, v.translation.height > (didScrollDownABitFirst ? -40 : 0) {
                                        verticalOffset = v.translation.height
                                        didScrollDownABitFirst = true
                                    }
                                }
                            }
                            .onEnded { v in
                                didScrollDownABitFirst = false
                                withAnimation {
                                    if !isAnimating, v.translation.height > 100 || v.predictedEndTranslation.height > 100 {
                                        isActive = false
                                    } else {
                                        verticalOffset  = .zero
                                    }
                                }
                            }
                    )
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0), value: isActive)
        .onChange(of: isActive) { b in
            if !b {
                verticalOffset = .zero
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.15) {
                    isAnimating = false
                }
            } else {
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    isAnimating = false
                }
            }
        }
        
    }
}

struct DrawerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContainerView(isActive: .constant(true), isAnimating: .constant(false))
    }
}
