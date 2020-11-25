//
//  ViewController.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CountriesInformationController: UIViewController {
    let vw = CountriesInformationView()
    
    // Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        // Calling initial setup method of the view
        vw.initialSetup()
        // Setting empty data -> it will show a message if data is not available
        self.settingEmptyDataSet(placeholder: "No Data Found", placeholderTV: vw.tblView, isLargeText: false, emptyDataState: .noData)
        // To update the navigation title
        vw.updateTitle = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let countryName = CountriesInformationDataSource.shared.getCountryName() {
                    self.title = countryName
                }
            }
        }
        vw.countryResultFetched = { [weak self] in
            guard let self = self else { return }
            self.settingEmptyDataSet(placeholder: "No Data Found", placeholderTV: self.vw.tblView, isLargeText: false, emptyDataState: .noData)
        }
    }
    
    override func loadView() {
        vw.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        // Assigning custom view to viewController's view
        self.view = vw
    }
    
    
}

