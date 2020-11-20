//
//  ViewController.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CountriesInformationController: UIViewController {
    // Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vw = self.view as? CountriesInformationView {
            // Calling initial setup method of the view
            vw.initialSetup()
            // To update the navigation title
            vw.updateTitle = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let countryName = CountriesInformationDataSource.shared.getCountryName() {
                        self.title = countryName
                    }
                }
            }
        }
    }
}

