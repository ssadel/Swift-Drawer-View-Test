//
//  DrawerView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct DrawerView: View {

    var isDraggingDrawer:Bool
    @Binding var isChildViewActive:Bool
    @Namespace private var drawerTransition
    private let defaultCells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friend", "Emoji Skin Tone", "Status Settings", "Account"]
    private let childCells:[String] = ["Notifications", "Change Username", "Change Number", "Delete Account", "Logout"]
    
    var body: some View {
        
        ZStack {
            if isChildViewActive {
                childView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.14)))
            } else {
                defaultView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 1.04).combined(with: .opacity).animation(.easeOut(duration: 0.14)))
            }
        }
        .padding(.top, 22.5) /// Padding for top bar
        .mask(drawerBackground)
        .background(
            GeometryReader { proxy in
                drawerBackground
                    .preference(key: ViewHeightKey.self, value: proxy.size.height)
            }
        )
        .padding(.bottom)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .padding(.horizontal, 10)
        .shadow(color: .gray.opacity(0.5), radius: 8)
        .animation(.easeOut(duration: 0.24), value: isChildViewActive)
        
    }
    
    var defaultView: some View {
        VStack {
            ForEach(defaultCells, id: \.self) { text in
                DrawerCell(text: text) {
                    isChildViewActive = true
                }
                .disabled(isDraggingDrawer)
            }
        }
    }
    
    var childView: some View {
        VStack {
            ForEach(childCells, id: \.self) { text in
                DrawerCell(text: text, foregroundColor: text == "Delete Account" || text == "Logout" ? .red : .primary)
                    .disabled(isDraggingDrawer)
            }
            BackButton {
                isChildViewActive = false
            }
        }
    }
    
    var drawerBackground: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(.white)
                .padding(.bottom, -20)
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 32, height: 3.5)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 7.5)
        }
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
