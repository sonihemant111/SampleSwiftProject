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
    private var countryInfoListViewModel = CountryInfoListViewModel()
    
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
            self.countryInfoListViewModel.fetchCountryData(isRefreshingList: true)
        }
        countryInfoListViewModel.delegate = self
        if (AppNetworking.isConnected()) {
            countryInfoListViewModel.fetchCountryData(isRefreshingList: false)
        } else {
            // show message
            self.countryInfoView.makeToast("Please check your Internet Connection")
            self.setupEmptyDataSet("Please check your Internet Connection")
            self.title = ""
        }
    }
    
    override func loadView() {
        // Assigning custom view to viewController's view
        countryInfoView.frame = UIScreen.main.bounds
        self.view = countryInfoView
    }
    
    // Method to set empty data set
    func setupEmptyDataSet(_ message: String) {
        self.settingEmptyDataSet(placeholderMessage: message, placeholderTV: self.countryInfoView.countryInfoTableView, isLargeText: false)
    }
}


// MARK: - API Response Delegate
//=============================
extension CountriesInformationController: CountryInfoListDelegate {
    func willHitApi(shouldPlayLoader: Bool) {
        // Show/ Hide Loader
        if shouldPlayLoader {
            self.countryInfoView.showHideLoader(true)
        } else {
            self.countryInfoView.showHideLoader(false)
        }
    }
    
    func didReceiveCountryData() {
        DispatchQueue.main.async {
            // update the navigation title with country name
            self.title = self.countryInfoListViewModel.getCountryName()
            self.countryInfoView.countryInfoListViewModel = self.countryInfoListViewModel
            // Hide Loader
            self.countryInfoView.showHideLoader(false)
            self.setupEmptyDataSet("No Data Found")
            self.countryInfoView.refreshList()
        }
    }
    
    func didReceiveError(message: String) {
        DispatchQueue.main.async {
            // Hide Loader
            self.countryInfoView.showHideLoader(false)
            // reload list
            self.countryInfoView.refreshList()
            self.setupEmptyDataSet("No Data Found")
            // show message
            self.countryInfoView.makeToast(message)
        }
    }
}
