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
