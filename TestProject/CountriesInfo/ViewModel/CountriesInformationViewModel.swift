//
//  CountriesInformationViewModel.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
// Country Information view model
class CountriesInformationViewModel {
    private let urlManager = URLManager()
    
    func fetchCountryData( _ completionHandler: @escaping (Result<CountryInformation, NSError>)-> Void) {
        // Call API to fetch all country's data
        guard let requestManager = RequestManager(url: urlManager.countyFacts, httpMethod: "GET") else {
            return
        }
        
        WebService.GET(requestObj: requestManager, success: { (data) in
            guard let info = data.decode(type: CountryInformation.self) else {
                let err = NSError(domain: "", code: 1222, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
                completionHandler(.failure(err))
                return
            }
            completionHandler(.success(info))
        }) { (err) -> (Void) in
            completionHandler(.failure(err))
        }
    }
    
    
}
