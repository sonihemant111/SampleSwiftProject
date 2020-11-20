//
//  CountriesInformationPresenter.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class CountriesInformationPresenter {
    typealias CountryDataCompletion = (_ arrCountryInfor: CountryInformation?) -> Void
    
    // Call API to fetch all country's data
    func fetchCountreyData( _ completionHandler: @escaping  CountryDataCompletion) {
        WebService.fetchCountryData(endPoint: WebService.EndPoint.countyFacts.rawValue, params: [:], headers: [:], loader: true) { (result) in
            switch result {
            case .failure(let error):
                printDebug(error)
            case .success(let countryResponse):
                completionHandler(countryResponse)
                printDebug(countryResponse)
            }
        }
    }
}
