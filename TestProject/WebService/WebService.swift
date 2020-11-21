//
//  Webservice.swift
//  TestProject
//
//  Created by Admin on 19/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

typealias SuccessResponse = (_ data : Data) -> ()
typealias FailureResponse = (NSError) -> (Void)
typealias JSONDictionary = [String: Any]
typealias JSONDictionaryArray = [JSONDictionary]

class WebService {
    
    static func GET(requestObj: RequestManager, loader: Bool = true, success: @escaping SuccessResponse, failure: @escaping FailureResponse) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        guard let request = requestObj.request else {
            return
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let str = String(decoding: Data(data), as: UTF8.self)
                if let data = str.data(using: String.Encoding.utf8 ) {
                    
                    if error != nil {
                        if let err = error as NSError? {
                            failure(err)
                        }
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        let code = httpResponse.statusCode
                        switch code {
                        case HttpStatusCode.success:
                            success(data)
                        default:
                            failure(NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
                        }
                    }
                }
            }
        }
        // execute the HTTP request
        task.resume()
    }
}
