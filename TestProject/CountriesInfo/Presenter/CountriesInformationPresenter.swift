//
//  CountriesInformationPresenter.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
typealias CountryDataCompletion = (_ arrCountryInfor: CountryInformation?, _ error: NSError?) -> Void

// CountriesInformationProtocol holds the method which consume webservice API
protocol CountriesInformationProtocol {
    func fetchCountreyData( _ completionHandler: @escaping  CountryDataCompletion)
}

// Presenter class
// This class will create a connection with webservice model to fetch the data from API
class CountriesInformationPresenter: CountriesInformationProtocol {
    private let urlManager = URLManager()
    // Call API to fetch all country's data
    func fetchCountreyData( _ completionHandler: @escaping  CountryDataCompletion) {
        
        guard let requestManager = RequestManager(url: urlManager.countyFacts, httpMethod: "GET") else {
            return
        }
        
        WebService.GET(requestObj: requestManager, success: { (data) in
            guard let info = data.decode(type: CountryInformation.self) else {
                let err = NSError(domain: "", code: 1222, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
                completionHandler(nil, err)
                return
            }
            completionHandler(info, nil)
        }) { (err) -> (Void) in
            completionHandler(nil, err)
        }
    }
}
