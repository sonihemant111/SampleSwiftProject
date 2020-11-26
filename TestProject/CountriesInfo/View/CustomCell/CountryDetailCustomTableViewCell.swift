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
    
    // IBOutlet
    @IBOutlet weak var containerView: UIView!
    
    // Label to display the title
    private let lblTitle : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // contentHolderView holds all the elements in cell
    private let contentHolderView : UIView = {
        let vw = UIView()
        return vw
    }()
    
    // Label to display the description
    private let lblDescription : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let img : UIImageView = {
        let imgView = UIImageView(image: UIImage())
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    // contentHolderSubStackView holding lblTitle and lblDescription
    private let contentHolderSubStackView : UIStackView = {
        let stackview = UIStackView()
        return stackview
    }()
    
    private let contentHolderStackView : UIStackView = {
        let stackview = UIStackView()
        return stackview
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureCell()
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        // Adding the views in parent view
        addSubview(contentHolderView)
        addSubview(img)
        
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
        img.translatesAutoresizingMaskIntoConstraints = false
        img.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        img.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        img.widthAnchor.constraint(equalToConstant: 90).isActive = true
        img.heightAnchor.constraint(equalToConstant: 90).isActive = true
        img.clipsToBounds = true
        
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
        contentHolderStackView.addArrangedSubview(img)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        // reset data
        self.img.image = UIImage()
        self.lblTitle.text = ""
        self.lblDescription.text = ""
    }
    
    // Method to configure the cell
    func configureCell() {
        lblTitle.numberOfLines = 0
        lblDescription.numberOfLines = 0
        self.setTextColor()
        self.setFont()
        // set corner radius of image
        self.img.layer.cornerRadius = 5.0
        self.img.clipsToBounds = true
        // set border of container view
        self.containerView.layer.borderWidth = 1.0
        self.containerView.layer.borderColor = AppColors.lightGrayColor.cgColor
        self.containerView.layer.cornerRadius = 5.0
        self.containerView.clipsToBounds = true
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
    func setUpData(_ objCountryData: CountryData) {
        // set image
        let imgUrl = URL(string: objCountryData.image ?? "")
        img.kf.setImage( with: imgUrl, placeholder: #imageLiteral(resourceName: "placeholderImage"))
        
        // set title and subtitle text
        lblTitle.text = objCountryData.title?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized ?? "Not available"
        lblDescription.text = objCountryData.description?.trimmingCharacters(in: .whitespacesAndNewlines).capitalizingFirstLetter() ?? "Not available"
        
        self.selectionStyle = .none
    }
}
