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
    let countryInfoTableView = UITableView()
    var countryInfoListViewModel: CountryInfoListViewModel!
    var refreshCountryData: (() -> Void)?
    private var refreshController = UIRefreshControl()
    private var loaderView: NVActivityIndicatorView!

    // Method to setup data initially
    func initialSetup() {
        self.configureViews()
    }
    
    override func layoutSubviews() {
        // updating frame of loader view
        loaderView.frame = CGRect(x: self.center.x - 25, y: self.center.y, width: 50, height: 50)
    }
    
    // setup Refresher controller
    private func setupRefreshController() {
        self.refreshController.tintColor = AppColors.charcoalGray
        self.countryInfoTableView.refreshControl = refreshController
        self.refreshController.addTarget(self,
                                         action: #selector(pullToRefreshCountryData),
                                         for: .valueChanged)
    }
    
    // pull to refresh the list of forums
    @objc func pullToRefreshCountryData() {
        if let callBack = refreshCountryData {
            callBack()
            self.refreshController.endRefreshing()
        }
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
        self.addSubview(countryInfoTableView)
        // Apply constraints on table view
        countryInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        countryInfoTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        countryInfoTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        countryInfoTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        countryInfoTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        // Register table view Cell
        countryInfoTableView.register(CountryDetailCustomTableViewCell.self, forCellReuseIdentifier: "CountryDetailCustomTableViewCell")
        // Hide the veritcal scroll
        countryInfoTableView.showsVerticalScrollIndicator = false
        // set delegate and datasource as self
        countryInfoTableView.delegate = self
        countryInfoTableView.dataSource = self
        countryInfoTableView.separatorStyle = .none
        // set content edgeInset
        countryInfoTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        // setup refresh controller
        self.setupRefreshController()
    }
    
    // Method to show/Hide loader
    func showHideLoader(_ show: Bool) {
        if show {
            self.loaderView.startAnimating()
            self.loaderView.isHidden = false
        } else {
            self.loaderView.stopAnimating()
            self.loaderView.isHidden = true
        }
    }
    
    // reload table view
    func refreshList() {
        self.countryInfoTableView.reloadData()
    }
}

// MARK:- TableView Delegate and DataSource
//=============================
extension CountriesInformationView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.countryInfoListViewModel == nil {
            return 0
        } else {
            return self.countryInfoListViewModel.numberOfSection
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryInfoListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailCustomTableViewCell", for: indexPath) as! CountryDetailCustomTableViewCell
        let countryInfoViewModel = self.countryInfoListViewModel.countryInfoAtIndex(indexPath.row)
        cell.setUpData(countryInfoViewModel)
        return cell
    }
}


//MARK:- Prefetching DataSource
//=============================
extension CountriesInformationView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { [weak self] (index) in
            guard let `self` = self else { return }
            let countryInfoViewModel = self.countryInfoListViewModel.countryInfoAtIndex(index.row)
            UIImageView.cacheImage(url: countryInfoViewModel.imgUrl)
        }
    }
}
