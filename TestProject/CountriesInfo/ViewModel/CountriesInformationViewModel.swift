//
//  CountriesInformationViewModel.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
// CountryInfoList View Model
class CountryInfoListViewModel {
    private let countryName: String
    private var arrCountryInfo = [CountryData]()
    
    var numberOfSection: Int {
        return 1
    }
    
    // Method to get country Name
    func getCompanyName() -> String {
        return self.countryName
    }
    
    // Method to get count if country info array
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.arrCountryInfo.count
    }
    
    // Method to get CountryInfoViewModel at specific index of arrCountryInfo
    func countryInfoAtIndex(_ index: Int) -> CountryInfoViewModel{
        let countryInfo = self.arrCountryInfo[index]
        return CountryInfoViewModel(countryInfo)
    }
    
    init(_ countryInfo: CountryInformation) {
        self.countryName = (countryInfo.countryName ?? "").capitalized
        guard let arrCountryData = countryInfo.countryData else { return }
        self.arrCountryInfo  = arrCountryData
    }
}

// Country Info view Model
struct CountryInfoViewModel {
    private let countryInfo: CountryData
    
    var imgUrl: String {
        return self.countryInfo.image ?? ""
    }
    
    var title: String {
        return (self.countryInfo.title?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized ?? "Not Available")
    }
    
    var description: String {
        return (self.countryInfo.description?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized ?? "Not Available").capitalized
    }
    
    init(_ countryInfo: CountryData) {
        self.countryInfo  = countryInfo
    }
}
