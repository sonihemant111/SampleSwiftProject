//
//  Webservice.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

typealias SuccessResponse = (_ data : Data) -> ()
typealias FailureResponse = (NSError) -> (Void)
typealias JSONDictionary = [String: Any]
typealias HTTPHeaders = [String: String]
typealias JSONDictionaryArray = [JSONDictionary]

var baseUrl: String {
    return "https://dl.dropboxusercontent.com/"
}

class WebService {
    enum EndPoint : String {
        case countyFacts = "s/2iodh4vg0eortkl/facts.json"
    }
    
    static func GET(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping SuccessResponse,
                    failure : @escaping FailureResponse) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let strUrl = baseUrl + endPoint
        let url = URL(string: strUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
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
                        case ApiCode.success:
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
    
    static func fetchCountryData( endPoint: String,
                                  params: JSONDictionary = [:],
                                  headers : HTTPHeaders = [:],
                                  loader: Bool = true,
                                  completion: @escaping (Result< CountryInformation, NSError>) -> Void) {
        WebService.GET(endPoint: endPoint, parameters: params, headers: headers, loader: loader, success: { (data) in
            
            guard let info = data.decode(type: CountryInformation.self) else {
                let err = NSError(domain: "", code: 1222, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
                completion(.failure(err))
                return
            }
            completion(.success(info))
        }) { (error) -> (Void) in
            completion(.failure(error))
        }
    }
    
}
