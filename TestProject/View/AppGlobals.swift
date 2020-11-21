//
//  AppGlobals.swift
//  TestProject
//
//  Created by Admin on 19/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

/// Print Debug
func printDebug<T>(_ obj : T) {
    #if DEBUG
    print(obj)
    #endif
    
}

// Class for Common Function
class CommonFunction {
    /// Show Activity Loader
    class func showActivityLoader() {
        DispatchQueue.main.async {
            // getting access to the window object from SceneDelegate
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate  else {
                    return
            }
            
            if let vc = sceneDelegate.window?.rootViewController {
                //vc.startNYLoader()
            }
        }
    }
}
