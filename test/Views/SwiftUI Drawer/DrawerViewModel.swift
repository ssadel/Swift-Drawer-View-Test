//
//  DrawerViewModel.swift
//  test
//
//  Created by Sidney Sadel on 5/7/23.
//

import Foundation

enum DrawerNavigationRoute: String {
    case Base
    case Account = "Account"
    case EditName = "Edit Name"
    case EditBio = "Edit Bio"
}

class DrawerViewModel:ObservableObject {
    
    @Published var drawerRoute:DrawerNavigationRoute = .Base
    
    let defaultCells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friend", "Emoji Skin Tone", "Status Settings", "Account"]
    let childCells:[String] = ["Notifications", "Change Username", "Change Number", "Delete Account", "Logout"]
    
    init() {
        print("DrawerViewModel init")
    }
    
}

