//
//  CountriesInformationModel.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

// Model to hold country information
struct CountryInformation: Codable {
    var countryName: String?
    var countryData: [CountryData]?
    
    enum CodingKeys: String, CodingKey {
        case countryName = "title"
        case countryData = "rows"
    }
}

// Model to hold the country specific data
struct CountryData: Codable {
    var title: String?
    var description: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case image = "imageHref"
    }
}

