//
//  Data+Extension.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension Data {
    // Method to decode data in respective model
    func decode<T: Decodable>(type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: self)
        } catch let error{
            printDebug(error.localizedDescription)
            return nil
        }
    }
}
