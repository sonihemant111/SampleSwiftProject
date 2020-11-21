//
//  TestProjectTests.swift
//  TestProjectTests
//
//  Created by Admin on 21/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import XCTest

@testable import TestProject

class TestProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test success scenario of json
    func testFetchCountryDataSuccess() {
        let objCountryInformation = CountriesInformationPresenterTest()
        let expectation = self.expectation(description: "Async call")
        objCountryInformation.fetchCountreyData { (model, err) in
            XCTAssertNil(err, "Error should be nil")
            XCTAssertNotNil(model, "Model should not be nil")
            XCTAssertEqual(model?.countryName, "About Canada", "Country name should be About Canada")
            XCTAssertEqual(model?.countryData?.count, 5, "Country array should have 5 object")
            // Testing data of country's 0 Index
            XCTAssertNotNil((model?.countryData?[0])?.title, "Title should not be nil")
            XCTAssertNotNil((model?.countryData?[0])?.description, "description should not be nil")
            XCTAssertNotNil((model?.countryData?[0])?.image, "image should not be nil")
            // Testing data of country's 1st Index
            XCTAssertNotNil((model?.countryData?[1])?.title, "Title should not be nil")
            XCTAssertNil((model?.countryData?[1])?.description, "description should be nil")
            XCTAssertNotNil((model?.countryData?[1])?.image, "image should not be nil")
            // Testing data of country's 2nd Index
            XCTAssertNotNil((model?.countryData?[2])?.title, "Title should not be nil")
            XCTAssertNotNil((model?.countryData?[2])?.description, "description should not be nil")
            XCTAssertNil((model?.countryData?[2])?.image, "image should be nil")
            // Testing data of country's 3rd Index
            XCTAssertNil((model?.countryData?[3])?.title, "Title should be nil")
            XCTAssertNil((model?.countryData?[3])?.description, "description should be nil")
            XCTAssertNil((model?.countryData?[3])?.image, "image should be nil")
            // Testing data of country's 4th Index
            XCTAssertNil((model?.countryData?[4])?.title, "Title should be nil")
            XCTAssertNotNil((model?.countryData?[4])?.description, "description should not be nil")
            XCTAssertNotNil((model?.countryData?[4])?.image, "image should not be nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    // Test failure scenario of json
    func testFetchCountryDataFail() {
        let objCountryInformation = CountriesInformationPresenterTestFail()
        let expectation = self.expectation(description: "Async call")
        objCountryInformation.fetchCountreyData { (model, err) in
            XCTAssertNil(err, "Error should be nil")
            XCTAssertNotNil(model, "Model should not be nil")
            XCTAssertEqual(model?.countryName, "About Canada", "Country name should be About Canada")
            XCTAssertEqual(model?.countryData?.count, 0, "Country array should be empty")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}


class CountriesInformationPresenterTest: CountriesInformationProtocol {
    func fetchCountreyData( _ completionHandler: @escaping  CountryDataCompletion) {
        let bundle = Bundle(for: type(of: self))
        let urlPath = bundle.path(forResource: "Success", ofType: "json")
        
        guard let path = urlPath else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            guard let info = data.decode(type: CountryInformation.self) else {
                let err = NSError(domain: "", code: 1222, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
                 completionHandler(nil,err)
                return
            }
            completionHandler(info, nil)
        } catch let err {
            completionHandler(nil,err as NSError)
        }
    }
}


class CountriesInformationPresenterTestFail: CountriesInformationProtocol {
    func fetchCountreyData( _ completionHandler: @escaping  CountryDataCompletion) {
        let bundle = Bundle(for: type(of: self))
        let urlPath = bundle.path(forResource: "Success_Empty", ofType: "json")
        
        guard let path = urlPath else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            guard let info = data.decode(type: CountryInformation.self) else {
                let err = NSError(domain: "", code: 1222, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
                 completionHandler(nil,err)
                return
            }
            completionHandler(info, nil)
        } catch let err {
            completionHandler(nil,err as NSError)
        }
    }
}
