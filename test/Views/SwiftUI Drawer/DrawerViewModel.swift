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
    // case CloseFriend = "Close Friends"
}

class DrawerViewModel:ObservableObject {
    
    @Published var drawerRoute:DrawerNavigationRoute = .Base
    
    @Published var isPhotosPickerActive:Bool = false
    @Published var photoItem:PhotosPickerItem?
    
    let defaultCells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friends", "Emoji Skin Tone", "Status Settings", "Account"]
    let childCells:[String] = ["Notifications", "Change Username", "Change Number", "Delete Account", "Logout"]
    
    init() {
        print("DrawerViewModel init")
    }
    
}

