//
//  ViewController.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CountriesInformationController: UIViewController {
    let countryInfoView = CountriesInformationView()
    
    // Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calling initial setup method of the view
        countryInfoView.initialSetup()
        // To update the navigation title
        countryInfoView.updateTitle = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let countryName = CountriesInformationDataSource.shared.getCountryName() {
                    self.title = countryName
                }
            }
        }
        // to do
        countryInfoView.countryResultFetched = { [weak self] in
            guard let self = self else { return }
            self.settingEmptyDataSet(placeholder: "No Data Found", placeholderTV: self.countryInfoView.tblView, isLargeText: false, emptyDataState: .noData)
        }
    }
    
    override func loadView() {
        // Assigning custom view to viewController's view
        self.view = countryInfoView
    }
    
}

