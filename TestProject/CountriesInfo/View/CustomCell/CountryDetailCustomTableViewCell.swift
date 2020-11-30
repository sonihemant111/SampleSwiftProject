//
//  TableViewCell.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class CountryDetailCustomTableViewCell: UITableViewCell {
    
    // Label to display the title
    private let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // contentHolderView holds all the elements in cell
    private let contentHolderView: UIView = {
        let vw = UIView()
        return vw
    }()
    
    // Label to display the description
    private let lblDescription: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let imgCountryInfo: UIImageView = {
        let imgView = UIImageView(image: UIImage())
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    // contentHolderSubStackView holding lblTitle and lblDescription
    private let contentHolderSubStackView: UIStackView = {
        let stackview = UIStackView()
        return stackview
    }()
    
    private let contentHolderStackView: UIStackView = {
        let stackview = UIStackView()
        return stackview
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        // Adding the views in parent view
        addSubview(contentHolderView)
        addSubview(imgCountryInfo)
        
        // setup/configure
        self.setupAllViewElement()
    }
    
    // Method to apply constraint on all the UIViews element
    func setupAllViewElement() {
        // set a border and corner radius on comntent view
        contentHolderView.layer.borderWidth = 1.0
        contentHolderView.layer.borderColor = AppColors.lightGrayColor.cgColor
        contentHolderView.layer.cornerRadius = 10.0
        contentHolderView.clipsToBounds = true
        
        // Confiquring contentHolderView (Constraints)
        contentHolderView.translatesAutoresizingMaskIntoConstraints = false
        contentHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        contentHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        contentHolderView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        contentHolderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        // Confiquring image (Constraints)
        imgCountryInfo.translatesAutoresizingMaskIntoConstraints = false
        imgCountryInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imgCountryInfo.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imgCountryInfo.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imgCountryInfo.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imgCountryInfo.clipsToBounds = true
        
        // Added title and description in stackview
        contentHolderSubStackView.addArrangedSubview(lblTitle)
        contentHolderSubStackView.addArrangedSubview(lblDescription)
        contentHolderSubStackView.backgroundColor = .red
        contentHolderSubStackView.translatesAutoresizingMaskIntoConstraints = false
        contentHolderSubStackView.axis = .vertical
        contentHolderSubStackView.distribution = .fill
        contentHolderSubStackView.spacing = 10
        contentHolderSubStackView.alignment = .top
        contentHolderSubStackView.isLayoutMarginsRelativeArrangement = true
        contentHolderSubStackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)

        // adding contentHolderSubStackView and image in main contentHolder stackView
        contentHolderStackView.addArrangedSubview(imgCountryInfo)
        contentHolderStackView.addArrangedSubview(contentHolderSubStackView)
        contentHolderStackView.translatesAutoresizingMaskIntoConstraints = false
        contentHolderStackView.axis = .horizontal
        contentHolderStackView.distribution = .fill
        contentHolderStackView.alignment = .top
        contentHolderStackView.spacing = 10
        contentHolderView.addSubview( contentHolderStackView)
        contentHolderStackView.isLayoutMarginsRelativeArrangement = true
        contentHolderStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // Confiquring image (Constraints)
        contentHolderStackView.centerXAnchor.constraint(equalTo: contentHolderView.centerXAnchor).isActive = true
        contentHolderStackView.centerYAnchor.constraint(equalTo: contentHolderView.centerYAnchor).isActive = true
        contentHolderStackView.widthAnchor.constraint(equalTo: contentHolderView.widthAnchor).isActive = true
        contentHolderStackView.heightAnchor.constraint(equalTo: contentHolderView.heightAnchor).isActive = true
        
         self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        // reset data
        self.imgCountryInfo.image = UIImage()
        self.lblTitle.text = ""
        self.lblDescription.text = ""
    }
    
    // Method to configure the cell
    func configureCell() {
        lblTitle.numberOfLines = 0
        lblDescription.numberOfLines = 0
        self.setTextColor()
        self.setFont()
    }
    
    // Method to set Font of the Labels
    func setFont() {
        self.lblTitle.font = UIFont(name: AppFonts.HelveticaBold.rawValue, size: 18)
        self.lblDescription.font = UIFont(name: AppFonts.HelveticaLight.rawValue, size: 15)
    }
    
    // Method to set color of UI Element
    func setTextColor() {
        self.lblTitle.textColor = AppColors.charcoalGray
        self.lblDescription.textColor = AppColors.darkGrayColor
    }
    
    // Method to setup data
    func setUpData(_ countryInfoViewModel: CountryInfoViewModel) {
        // set image
        let imgUrl = URL(string: countryInfoViewModel.imgUrl)
        imgCountryInfo.kf.setImage( with: imgUrl, placeholder: #imageLiteral(resourceName: "placeholderImage"))
        
        // set title and subtitle text
        lblTitle.text = countryInfoViewModel.title.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        lblDescription.text = countryInfoViewModel.description.trimmingCharacters(in: .whitespacesAndNewlines).capitalizingFirstLetter()
        
        self.selectionStyle = .none
    }
}
