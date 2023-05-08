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
    @ObservedObject var viewModel:DrawerViewModel
    var isDraggingDrawer:Bool
    var isFocused:FocusState<Bool>.Binding
    
    @Namespace private var drawerTransition
    
    var body: some View {
        
        ZStack {
            switch viewModel.drawerRoute {
            case .Base:
                baseView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 1.04).combined(with: .opacity).animation(.easeOut(duration: 0.07)))
            case .Account:
                accountView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.07)))
            case .EditName:
                editNameView
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.11)))
            case .EditBio:
                editBioView
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
        .padding(.bottom, (viewModel.drawerRoute == .EditName || viewModel.drawerRoute == .EditBio) ? 314 : 0) // TODO: Dynamically get keyboard height before isFocused = true and store globally
        .animation(.easeOut(duration: 0.2), value: viewModel.drawerRoute)
    }
    
    private var baseView: some View {
        VStack {
            ForEach(viewModel.defaultCells, id: \.self) { text in
                DrawerCell(text: text) {
                    switch text {
                    case DrawerNavigationRoute.EditName.rawValue:
                        isFocused.wrappedValue = true
                        viewModel.drawerRoute = .EditName
                    case DrawerNavigationRoute.EditBio.rawValue:
                        isFocused.wrappedValue = true
                        viewModel.drawerRoute = .EditBio
                    case DrawerNavigationRoute.Account.rawValue:
                        viewModel.drawerRoute = .Account
                    default:
                        break
                    }
                }
                .disabled(isDraggingDrawer)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var accountView: some View {
        VStack {
            ForEach(viewModel.childCells, id: \.self) { text in
                DrawerCell(text: text, foregroundColor: text == "Delete Account" || text == "Logout" ? .red : .primary)
                    .disabled(isDraggingDrawer)
            }
            BackButton {
                viewModel.drawerRoute = .Base
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var editNameView: some View {
        VStack {
            TextField("Name", text: .constant("Sid"))
                .font(.subheadline.weight(.semibold))
                .padding(.horizontal)
                .padding(.vertical, 7.5)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(.gray.opacity(0.1)))
                .padding(.horizontal)
                .padding(.bottom, 10)
                .focused(isFocused)
                .accentColor(.green)
                .onAppear {
                    isFocused.wrappedValue = true
                }
            HStack {
                Button {
                    self.dismissKeyboard()
                    viewModel.drawerRoute = .Base
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
                    viewModel.drawerRoute = .Base
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
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var editBioView: some View {
        VStack {
            TextEditor(text: .constant("Yooo"))
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .font(.subheadline.weight(.semibold))
                .frame(height: 95)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(.gray.opacity(0.1)))
                .padding(.horizontal)
                .padding(.bottom, 10)
                .focused(isFocused)
                .accentColor(.green)
                .onAppear {
                    isFocused.wrappedValue = true
                }
            HStack {
                Button {
                    self.dismissKeyboard()
                    viewModel.drawerRoute = .Base
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
                    viewModel.drawerRoute = .Base
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
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var drawerBackground: some View {
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
        //DrawerView(isDraggingDrawer: false, drawerRoute: .constant(.EditName), isFocused: FocusState(true))
    }
}
