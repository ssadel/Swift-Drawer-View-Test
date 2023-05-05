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
    @Binding var drawerRoute:DrawerNavigationRoute
    @Namespace private var drawerTransition
    @FocusState private var isFocused:Bool
    
    private let defaultCells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friend", "Emoji Skin Tone", "Status Settings", "Account"]
    private let childCells:[String] = ["Notifications", "Change Username", "Change Number", "Delete Account", "Logout"]
    
    var body: some View {
        
        ZStack {
            switch drawerRoute {
            case .Base:
                baseView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 1.04).combined(with: .opacity).animation(.easeOut(duration: 0.11)))
            case .Account:
                accountView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.11)))
            case .EditName:
                editNameView
                    // .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.11)))
            }
        }
        .padding(.top, 22.5) /// Padding for top bar
        .mask(drawerBackground)
        .background(
            GeometryReader { proxy in
                drawerBackground
                    .preference(key: ViewHeightKey.self, value: proxy.size.height)
            }
            , alignment: .top
        )
        .padding(.bottom)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .padding(.horizontal, 10)
        .shadow(color: .gray.opacity(0.4), radius: 8)
        .padding(.bottom, drawerRoute == .EditName ? 310 : 0) /// Keyboard Height
        .animation(.easeOut(duration: 0.24), value: drawerRoute)
    }
    
    var baseView: some View {
        VStack {
            ForEach(defaultCells, id: \.self) { text in
                DrawerCell(text: text) {
                    switch text {
                    case "Edit Name":
                        isFocused = true
                        drawerRoute = .EditName
                    case "Account":
                        drawerRoute = .Account
                    default:
                        break
                    }
                }
                .disabled(isDraggingDrawer)
            }
        }
    }
    
    var accountView: some View {
        VStack {
            ForEach(childCells, id: \.self) { text in
                DrawerCell(text: text, foregroundColor: text == "Delete Account" || text == "Logout" ? .red : .primary)
                    .disabled(isDraggingDrawer)
            }
            BackButton {
                drawerRoute = .Base
            }
        }
    }
    
    var editNameView: some View {
        VStack {
            TextField("Name", text: .constant("Sid"))
                .font(.subheadline.weight(.semibold))
                .padding(.horizontal)
                .padding(.vertical, 7.5)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(.gray.opacity(0.1)))
                .padding(.horizontal)
                .padding(.bottom, 10)
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
            HStack {
                Button {
                    self.dismissKeyboard()
                    drawerRoute = .Base
                } label: {
                    Text("Cancel")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundColor(.primary)
                        .font(.subheadline.weight(.semibold))
                        .background(Capsule(style: .continuous).foregroundColor(.gray.opacity(0.1)))
                }
                .buttonStyle(InteractiveButtonStyle())
                Spacer()
                Button {
                    self.dismissKeyboard()
                    drawerRoute = .Base
                } label: {
                    Text("Save")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.semibold))
                        .background(Capsule(style: .continuous).foregroundColor(.green))
                }
                .buttonStyle(InteractiveButtonStyle())
            }
            .padding(.horizontal)
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
        //BaseView()
        DrawerView(isDraggingDrawer: false, drawerRoute: .constant(.EditName))
    }
}
