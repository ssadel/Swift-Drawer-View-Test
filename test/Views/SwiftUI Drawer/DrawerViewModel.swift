//
//  DrawerViewModel.swift
//  test
//
//  Created by Sidney Sadel on 5/7/23.
//

import Foundation
import _PhotosUI_SwiftUI

enum DrawerNavigationRoute: String {
    case Base
    case Account = "Account"
    case EditName = "Edit Name"
    case EditBio = "Edit Bio"
    case ProfilePicture = "Change Profile Image"
    case CloseFriends = "Close Friends"
    case Emoji = "Emoji Skin Tone"
    case StatusSettings = "Status Settings"
}

class DrawerViewModel:ObservableObject {
    
    @Published var drawerRoute:DrawerNavigationRoute = .Base {
        didSet {
            shouldApplyKeyboardPadding = (drawerRoute == .EditName || drawerRoute == .EditBio)
        }
    }
    @Published var shouldApplyKeyboardPadding:Bool = false
    
    @Published var nameText:String = "Sid"
    @Published var bioText:String = "Yooo"
    @Published var shouldShakeDrawer:Bool = false
    @Published var isPhotosPickerActive:Bool = false
    @Published var photoItem:PhotosPickerItem?
    @Published var selectedEmoji:String = "✋"
    @Published var isStatusToggleEnabled:Bool = false
    
    let defaultCells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friends", "Emoji Skin Tone", "Status Settings", "Account"]
    let childCells:[String] = ["Notifications", "Change Username", "Change Number", "Delete Account", "Logout"]
    let handEmojis:[String] = ["✋🏻", "✋🏼", "✋🏽", "✋🏾", "✋🏿", "✋"]
    let keyboardHeight:CGFloat = 314 // TODO: Dynamically get keyboard height before isFocused = true and store globally
    
    init() {
        print("DrawerViewModel init")
    }
    
}

