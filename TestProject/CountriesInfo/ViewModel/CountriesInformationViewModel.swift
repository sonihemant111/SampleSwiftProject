//
//  CountriesInformationViewModel.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

// Protocol CountryInfoListDelegate (API Response Delegate)
protocol CountryInfoListDelegate: class {
    func willHitApi(shouldPlayLoader: Bool)
    func didReceiveCountryData()
    func didReceiveError(message: String)
}

// CountryInfoList View Model
class CountryInfoListViewModel {
    private var countryName: String = ""
    private var arrCountryInfo = [CountryData]()
    var delegate: CountryInfoListDelegate?
    var numberOfSection: Int {
        return 1
    }
    
    // Method to get country Name
    func getCountryName() -> String {
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


extension CountryInfoListViewModel {
    // Method to fetch country Data
    func fetchCountryData(isRefreshingList: Bool) {
        if isRefreshingList {
            self.delegate?.willHitApi(shouldPlayLoader: false)
        } else {
            self.delegate?.willHitApi(shouldPlayLoader: true)
        }
        
        // create url
        let urlManager = URLManager()
        let url = urlManager.countyFacts
        
        WebService.fetchCountryData(url) { (result) in
            switch result {
            case .success(let model):
                self.countryName = (model.countryName ?? "").capitalized
                guard let arrCountryData = model.countryData else { return }
                self.arrCountryInfo = arrCountryData
                self.delegate?.didReceiveCountryData()
            case .failure(let err):
                print(err)
                self.delegate?.didReceiveError(message: err.localizedDescription)
            }
        }
    }
}
