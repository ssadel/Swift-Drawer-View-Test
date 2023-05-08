//
//  DrawerView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI
import PhotosUI
import Introspect

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct DrawerView: View {
    @ObservedObject var viewModel:DrawerViewModel
    var isDraggingDrawer:Bool
    var isFocused:FocusState<Bool>.Binding
    
    @Namespace private var drawerTransition
    
    // @State private var customDelegate = CustomScrollViewDelegate()
    
    var body: some View {
        
        ZStack {
            switch viewModel.drawerRoute {
            case .Base:
                baseView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center) // Mess around with anchor to get morph effect
                    .transition(.scale(scale: 1.04).combined(with: .opacity).animation(.easeOut(duration: 0.085)))
            case .EditName:
                editNameView
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.11)))
            case .EditBio:
                editBioView
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.11)))
            case .CloseFriends:
                closeFriendsView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.085)))
            case .Emoji:
                emojiSkinToneView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.085)))
            case.StatusSettings:
                statusSettingsView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.085)))
            case .Account:
                accountView
                    .matchedGeometryEffect(id: "DrawerNavigation", in: drawerTransition, properties: [.frame, .size], anchor: .center)
                    .transition(.scale(scale: 0.96).combined(with: .opacity).animation(.easeOut(duration: 0.085)))
            default:
                Text("Nothing to see here")
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
        .padding(.bottom, viewModel.shouldApplyKeyboardPadding ? viewModel.keyboardHeight : 0)
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
                    case DrawerNavigationRoute.ProfilePicture.rawValue:
                        viewModel.isPhotosPickerActive = true
                    case DrawerNavigationRoute.CloseFriends.rawValue:
                        viewModel.drawerRoute = .CloseFriends
                    case DrawerNavigationRoute.Emoji.rawValue:
                        viewModel.drawerRoute = .Emoji
                    case DrawerNavigationRoute.StatusSettings.rawValue:
                        viewModel.drawerRoute = .StatusSettings
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
        .photosPicker(isPresented: $viewModel.isPhotosPickerActive, selection: $viewModel.photoItem, photoLibrary: .shared())
    }
    
    private var editNameView: some View {
        VStack {
            TextField("Name", text: $viewModel.nameText)
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
                .onSubmit {
                    self.dismissKeyboard()
                    viewModel.drawerRoute = .Base
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
            TextEditor(text: $viewModel.bioText)
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
                .onChange(of: viewModel.bioText) { _ in
                    if !viewModel.bioText.filter({ $0.isNewline }).isEmpty {
                        let _ = viewModel.bioText.popLast()
                        HapticManager.instance.notification(type: .error)
                        viewModel.shouldShakeDrawer = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.24, execute:{ viewModel.shouldShakeDrawer = false})
                    }
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
    
    private var closeFriendsView: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.subheadline.weight(.medium))
                TextField("Search People", text: .constant(""))
                    .font(.subheadline.weight(.semibold))
                    .focused(isFocused)
                    .accentColor(.blue)
                    .onChange(of: isFocused.wrappedValue) { b in
                        withAnimation(.easeOut(duration: 0.2)) { viewModel.shouldApplyKeyboardPadding = b }
                    }
            }
            .foregroundColor(.gray.opacity(0.7))
            .padding(.horizontal)
            .padding(.vertical, 7.5)
            .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(.gray.opacity(0.1)))
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            ScrollView {
                VStack {
                    Text("Suggested")
                        .font(.footnote.weight(.medium))
                        .foregroundColor(.gray.opacity(0.9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top, 4)
                    
                    ForEach(0..<3) { _ in
                        CloseFriendCell()
                    }
                }
            }
            .introspectScrollView(customize: { scrollView in
                scrollView.isScrollEnabled = false
//                customDelegate.onScroll = { scrollView in
//                    let translation = scrollView.panGestureRecognizer.translation(in: scrollView).y
//                    let contentOffset = scrollView.contentOffset.y
//
//                    print("Translation:", translation)
//                    print("Content Offset:", contentOffset)
//
//                    if translation > 0 && contentOffset <= 0 {
//                        // Scrolling down and reached the top edge of the ScrollView
//                        scrollView.isScrollEnabled = false
//                    } else if translation < 0 && contentOffset >= (scrollView.contentSize.height - scrollView.bounds.height) {
//                        // Scrolling up and reached the bottom edge of the ScrollView
//                        scrollView.isScrollEnabled = false
//                    } else {
//                        // Allow scrolling in other cases
//                        scrollView.isScrollEnabled = true
//                    }
//                }
//                scrollView.customDelegate = customDelegate
//                scrollView.delegate = customDelegate
            })
            .frame(height: UIScreen.main.bounds.height/1.75 - (viewModel.shouldApplyKeyboardPadding ? viewModel.keyboardHeight - 75 : 0))
            .overlay(
                LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
                    .frame(height: 7.5)
                , alignment: .top
            )
            
            Button {
                self.dismissKeyboard()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                    viewModel.drawerRoute = .Base
                }
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .background(Capsule(style: .continuous).foregroundColor(.blue))
                    .padding(.horizontal)
            }
            .buttonStyle(InteractiveButtonStyle())
        }
    }
    
    private var emojiSkinToneView: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(viewModel.handEmojis, id:\.self) { emoji in
                    Button {
                        viewModel.selectedEmoji = emoji
                    } label: {
                        Text(emoji)
                            .font(.system(size: 80))
                            .minimumScaleFactor(0.5)
                            .padding(15)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(viewModel.selectedEmoji == emoji ? .green.opacity(0.18) : .gray.opacity(0.12)))
                    }
                    .buttonStyle(InteractiveButtonStyle())
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            Button {
                viewModel.drawerRoute = .Base
            } label: {
                Text("Done")
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(10)
                    .background(Capsule(style: .continuous).foregroundColor(.green))
                    .padding(.horizontal)
            }
            .buttonStyle(InteractiveButtonStyle())

        }
    }
    
    private var statusSettingsView: some View {
        VStack {
            Toggle("Hide statuses older than", isOn: $viewModel.isStatusToggleEnabled)
                .padding(.horizontal)
                .padding(.vertical, 7.5)
                .background(RoundedRectangle(cornerRadius: 16, style: .continuous).foregroundColor(.gray.opacity(0.12)))
                .padding(.horizontal)
                .font(.subheadline.weight(.semibold))
            VStack(alignment: .leading, spacing: 20) {
                Text("24 hours")
                Text("1 week")
                Text("1 month")
                Text("3 months")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 25)
            .padding(.vertical)
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.gray.opacity(0.4))
            
            Button {
                viewModel.drawerRoute = .Base
            } label: {
                Text("Done")
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(10)
                    .background(Capsule(style: .continuous).foregroundColor(.green))
                    .padding(.horizontal)
            }
            .buttonStyle(InteractiveButtonStyle())
        }
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
        // DrawerView(isDraggingDrawer: false, drawerRoute: .constant(.EditName), isFocused: FocusState(true))
    }
}
