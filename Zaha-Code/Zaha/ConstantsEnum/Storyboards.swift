//
//  Storyboards.swift
//

import Foundation
import UIKit

public enum Storyboards : String {
    
    // As enum is extends from String then its case name is also its value
    case main = "Main"
    case walkthrough = "Walkthrough"
    case registeration = "LoginModule"
    case home = "HomeModule"
    case setting = "SettingModule"
    case sideMenu = "SideMenu"
    case booking = "Booking"
    case upcommingExperience = "UpcommingExperienceModule"
    
}

enum Navigation {
    static var currentNavigation  : UINavigationController?  = nil
}

;
