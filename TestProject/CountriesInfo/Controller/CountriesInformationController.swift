//
//  ViewController.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CountriesInformationController: UIViewController {
    let countryInfoView = CountriesInformationView()
    private var countryInfoListViewModel: CountryInfoListViewModel!
    
    // Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Calling initial setup method of the view
        countryInfoView.initialSetup()
        // set title initially
        self.title = "loading.."
        // pull to refresh update data
        countryInfoView.refreshCountryData = { [weak self] in
            guard let self = self else { return }
            self.getCountryData(true)
        }
        self.getCountryData()
    }    
    
    // Refresh Fav Feed
    @objc func getCountryData(_ isRefreshing: Bool = false) {
        if (AppNetworking.isConnected()) {
            // Call API to fetch the result
            if !isRefreshing {
                self.countryInfoView.showHideLoader(true)
            }
            // create url
            let urlManager = URLManager()
            let url = urlManager.countyFacts
            
            WebService.fetchCountryData(url) { (result) in
                switch result {
                case .success(let model):
                    self.countryInfoListViewModel = CountryInfoListViewModel(model)
                    self.countryInfoView.countryInfoListViewModel = self.countryInfoListViewModel
                    // set navigation title
                    DispatchQueue.main.async {
                        self.title = self.countryInfoListViewModel.getCompanyName()
                    }
                case .failure(let err):
                    print(err)
                    self.countryInfoView.makeToast(err.localizedDescription)
                }
                DispatchQueue.main.async {
                    // Update the title of the screen with fetched country name
                    self.countryInfoView.refreshList()
                    self.countryInfoView.showHideLoader(false)
                    self.settingEmptyDataSet(placeholder: "No Data Found", placeholderTV: self.countryInfoView.countryInfoTableView, isLargeText: false, emptyDataState: .noData)
                }
            }
        } else {
            // show message
            self.countryInfoView.makeToast("Please check your Internet Connection")
        }
    }
    
    override func loadView() {
        // Assigning custom view to viewController's view
        self.view = countryInfoView
    }
}

