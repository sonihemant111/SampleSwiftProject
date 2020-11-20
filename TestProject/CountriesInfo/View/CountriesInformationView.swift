//
//  CountriesInformationView.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Toast_Swift

class CountriesInformationView: UIView {
    
    // IBOutlets
    @IBOutlet weak var tblView: UITableView!    
    
    // Variables
    private var refreshController = UIRefreshControl()
    private var objCountriesInformationViewModel = CountriesInformationViewModel()
    private var objDataSource = CountriesInformationDataSource.shared
    var updateTitle: (() -> Void)?
    
    // Method to setup data initially
    func initialSetup() {
        self.configureTableView()
        self.setupRefreshController()
        self.fetchCountryData()
    }
    
    // setup Refresher controller
    private func setupRefreshController() {
        self.refreshController.tintColor = AppColors.charcoalGray
        self.tblView.refreshControl = refreshController
        self.refreshController.addTarget(self,
                                         action: #selector(pullToRefreshCountryData),
                                         for: .valueChanged)
    }
    
    // pull to refresh the list of forums
    @objc func pullToRefreshCountryData() {
        self.refreshController.endRefreshing()
        self.fetchCountryData()
    }
    
    // Method to confiqure the table view
    private func configureTableView() {
        // set estimated heigth of table view
        tblView.estimatedRowHeight = 100
        // set delegate and datasource as self
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        // set content edgeInset
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    // Refresh Fav Feed
    @objc func fetchCountryData() {
        if (AppNetworking.isConnected()) {
            // Call API to fetch the result
            objCountriesInformationViewModel.objCountriesInformationPresenter.fetchCountreyData { [weak self] (model) in
                guard let self = self, let model = model, let arrCountryData = model.countryData else { return }
                self.objDataSource.setCountryData(arrCountryData)
                self.objDataSource.setCountryName(model.countryName ?? "")
                // Update the title of the screen with fetched country name
                if let callBack = self.updateTitle {
                    callBack()
                }
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        } else {
            // show message
            self.makeToast("Please check your Internet Connection")
        }
    }
}

// MARK:- TableView Delegate and DataSource
//=============================
extension CountriesInformationView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arrCountryData = self.objDataSource.getCountryData() else {
            return 0
        }
        return arrCountryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailCustomTableViewCell", for: indexPath) as! CountryDetailCustomTableViewCell
        if let objCountryData = self.objDataSource.getCountryDataOfIndex(indexPath.row) {
            cell.setUpData(objCountryData)
        }
        return cell
    }
}


//MARK:- Prefetching DataSource
//=============================
extension CountriesInformationView: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { [weak self] (index) in
            guard let `self` = self else { return }
            
            if let objCountryData = self.objDataSource.getCountryDataOfIndex(index.row) {
            }
        }
    }
}
