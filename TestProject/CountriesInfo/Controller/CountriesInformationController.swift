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
    
    override func viewDidLayoutSubviews() {
        countryInfoView.frame = self.view.frame
    }
    
    // Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Calling initial setup method of the view
        countryInfoView.initialSetup()
        // set title initially
        self.title = StringConstants.loadingMessage
        // pull to refresh update data
        countryInfoView.refreshCountryData = { [weak self] in
            guard let self = self else { return }
            self.fetchData(true)
        }
        countryInfoListViewModel.delegate = self
        self.fetchData()
    }
    
    func fetchData(_ isRefreshingList: Bool = false) {
        if (AppNetworking.isConnected()) {
            countryInfoListViewModel.fetchCountryData(isRefreshingList: isRefreshingList)
        } else {
            // show message
            self.countryInfoView.makeToast(StringConstants.noInternetConnectionMessage)
            self.setupEmptyDataSet(StringConstants.noInternetConnectionMessage)
            self.title = ""
            if isRefreshingList {
                self.countryInfoView.stopRefreshing()
            }
        }
    }
    
    override func loadView() {
        // Assigning custom view to viewController's view
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
    
    func didReceiveCountryData(isRefreshingList: Bool) {
        DispatchQueue.main.async {
            // update the navigation title with country name
            self.title = self.countryInfoListViewModel.getCountryName()
            self.countryInfoView.countryInfoListViewModel = self.countryInfoListViewModel
            // stop refreshing refreshController if it is animating
            if isRefreshingList {
                self.countryInfoView.stopRefreshing()
            }
            // Hide Loader
            self.countryInfoView.showHideLoader(false)
            self.setupEmptyDataSet(StringConstants.noDataFoundMessage)
            self.countryInfoView.refreshList()
        }
    }
    
    func didReceiveError(isRefreshingList: Bool, message: String) {
        DispatchQueue.main.async {
            // stop refreshing refreshController if it is animating
            if isRefreshingList {
                self.countryInfoView.stopRefreshing()
            }
            // Hide Loader
            self.countryInfoView.showHideLoader(false)
            // reload list
            self.countryInfoView.refreshList()
            self.setupEmptyDataSet(StringConstants.noDataFoundMessage)
            // show message
            self.countryInfoView.makeToast(message)
        }
    }
}
