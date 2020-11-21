//
//  AppNetworking.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum AppNetworking {
    
    static func isConnected() -> Bool {
        do {
            return try Reachability().connection != .unavailable
        } catch {
            return false
        }
    }
    
    
}
