//
//  APIConfig.swift
//  TestProject
//
//  Created by Munendra Singh on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class URLManager {
    private var baseUrl: String {
        return "https://dl.dropboxusercontent.com/"
    }
    
    var countyFacts: String {
        return baseUrl + "s/2iodh4vg0eortkl/facts.json"
    }
    
    init() { }
}

