//
//  Request.swift
//  TestProject
//
//  Created by Munendra Singh on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class RequestManager {
    private var _request: URLRequest?
    private var headers = ["Content-Type": "application/json", "Accept":"application/json"]
    private var httpBody: Data?
    
    var request: URLRequest? {
        guard let re = _request else {
            return nil
        }
        return re
    }
    
    init?(url: String, httpMethod: String, httpBody: Data? = nil) {
        guard let urlObj = URL(string: url) else {
            return nil
        }
        
        if(httpMethod == "POST" && httpBody == nil) {
            return nil
        }
        
        _request = URLRequest(url: urlObj)
        _request?.httpBody = httpBody
        _request?.httpMethod = httpMethod
        _request?.allHTTPHeaderFields = headers
    }
    
    func addHeader(key: String, value: String) {
        _request?.setValue(value, forHTTPHeaderField: key)
    }
}
