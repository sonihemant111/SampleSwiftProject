//
//  CountriesInformationView.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Toast_Swift
import Kingfisher
import NVActivityIndicatorView

class CountriesInformationView: UIView {
    // Variables
    let tblView = UITableView()
    var loaderView: NVActivityIndicatorView!
    private var refreshController = UIRefreshControl()
    private var countriesInformationViewModel = CountriesInformationViewModel()
    private var countryDataSource = CountriesInformationDataSource.shared
    var updateTitle: (() -> Void)?
    var countryResultFetched: (() -> Void)?
    
    // Method to setup data initially
    func initialSetup() {
        self.configureViews()
        self.setupRefreshController()
        self.fetchCountryData()
    }
    
    override func layoutSubviews() {
        // updating frame of loader view
        loaderView.frame = CGRect(x: self.center.x - 25, y: self.center.y, width: 50, height: 50)
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
        self.fetchCountryData(true)
    }
    
    // Method to configure UI Element
    func configureViews() {
        self.configureTableView()
        // Add loader view
        loaderView = NVActivityIndicatorView(frame: CGRect(x: self.center.x - 25, y: self.center.y, width: 50, height: 50), type: .ballClipRotate, color: AppColors.darkGrayColor, padding: 0.0)
        self.addSubview(loaderView)
    }
    
    // Method to configure the table view
    private func configureTableView() {
        // Adding table view in controller's view
        self.addSubview(tblView)
        // Apply constraints on table view
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tblView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tblView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tblView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        // Register table view Cell
        tblView.register(CountryDetailCustomTableViewCell.self, forCellReuseIdentifier: "CountryDetailCustomTableViewCell")
        // Hide the veritcal scroll
        tblView.showsVerticalScrollIndicator = false
        // set delegate and datasource as self
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        // set content edgeInset
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    // Method to reload data once result fetched
    func reloadCountryData() {
        if let callBack = self.updateTitle {
            callBack()
        }
        DispatchQueue.main.async {
            if let callBack = self.countryResultFetched {
                callBack()
            }
            self.tblView.reloadData()
        }
    }
    
    // Refresh Fav Feed
    @objc func fetchCountryData(_ isRefreshing: Bool = false) {
        if (AppNetworking.isConnected()) {
            // Call API to fetch the result
            if !isRefreshing {
                self.loaderView.startAnimating()
                self.loaderView.isHidden = false
            }

            countriesInformationViewModel.fetchCountryData { (result) in
                switch result {
                case .success(let model):
                    guard let arrCountryData = model.countryData else { return }
                    self.countryDataSource.setCountryData(arrCountryData)
                    self.countryDataSource.setCountryName(model.countryName ?? "")
                case .failure(let err):
                    self.makeToast(err.localizedDescription)
                }
                DispatchQueue.main.async {
                    // Update the title of the screen with fetched country name
                    self.reloadCountryData()
                    self.loaderView.stopAnimating()
                    self.loaderView.isHidden = true
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
        guard let arrCountryData = self.countryDataSource.getCountryData() else {
            return 0
        }
        return arrCountryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailCustomTableViewCell", for: indexPath) as! CountryDetailCustomTableViewCell
        if let objCountryData = self.countryDataSource.getCountryDataOfIndex(indexPath.row) {
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
            
            if let objCountryData = self.countryDataSource.getCountryDataOfIndex(index.row) {
                UIImageView.cacheImage(url: objCountryData.image ?? "")
            }
        }
    }
}
