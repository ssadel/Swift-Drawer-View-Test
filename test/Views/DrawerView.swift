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
    @Namespace var navigate
    let cells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friend", "Emoji Skin Tone", "Status Settings", "Account"]
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 32, height: 3.5)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 15)
                .padding(.bottom, 10)
            
            ZStack {
                if isChildViewActive {
                    childView
                    //.matchedGeometryEffect(id: "ChildViewNavigation", in: navigate)
                } else {
                    defaultView
                        .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .identity))
                    //.matchedGeometryEffect(id: "ChildViewNavigation", in: navigate)
                }
            }
            .mask(
                drawerBackground
            )
            .frame(maxWidth: .infinity)
        }
        .background(
            GeometryReader { proxy in
                drawerBackground
                    .preference(key: ViewHeightKey.self, value: proxy.size.height)
            }
        )
        .padding(.bottom)
        .padding(.horizontal, 10)
        .animation(.easeOut(duration: 0.24), value: isChildViewActive)
        
    }
    
    var defaultView: some View {
        VStack {
            ForEach(cells, id: \.self) { text in
                DrawerCell(text: text) {
                    isChildViewActive = true
                }
                .disabled(isDraggingDrawer)
            }
        }
    }
    
    var childView: some View {
        VStack {
            Text("yo")
                .padding()
            Text("tyo")
                .padding()
            Text("yoo")
                .padding()
            Button {
                isChildViewActive = false
            } label: {
                Text("Go Back")
            }

        }
    }
    
    var drawerBackground: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundColor(.white)
            .shadow(color: .gray.opacity(0.5), radius: 8)
            .padding(.bottom, -20)
    }
    
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(isDraggingDrawer: false, isChildViewActive: .constant(false))
    }
}
