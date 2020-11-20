//
//  AppFont.swift
//  TestProject
//
//  Created by Admin on 19/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

enum AppFonts : String {
    case HelveticaBold = "Helvetica-Bold"
    case HelveticaLight = "Helvetica-Light"
}

extension AppFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }
}
