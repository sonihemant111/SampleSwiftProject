//
//  CountriesInformationDataSource.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

// This class treated as a data source and written methods to get the details that we fetched from API
class CountriesInformationDataSource {
    private var countryName: String?
    private var arrCountryData:[CountryData]?
    static let shared = CountriesInformationDataSource()
    private init(){}
    
    // Method to set country data
    func setCountryData(_ arrCountryData:[CountryData]) {
        self.arrCountryData = arrCountryData
    }
    
    // Method to get country data
    func getCountryData() -> [CountryData]? {
        guard let arrCountryData = self.arrCountryData else { return nil }
        return arrCountryData
    }
    
    // Method to get country data of specific index
    func getCountryDataOfIndex(_ index: Int) -> CountryData? {
        guard let arrCountryData = self.arrCountryData, arrCountryData.indices.contains(index) else { return nil }
        return arrCountryData[index]
    }
    
    // Method to set title/Country name
    func setCountryName(_ strtitle: String) {
        self.countryName = strtitle
    }
    
    // Method to get title/Country name
    func getCountryName() -> String? {
        return countryName
    }
}

