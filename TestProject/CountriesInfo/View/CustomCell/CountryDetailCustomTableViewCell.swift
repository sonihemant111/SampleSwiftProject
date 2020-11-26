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
    
    // Label to display the title
    private let contentHolderView : UIView = {
        let vw = UIView()
        return vw
    }()
    
    // Label to display the title
    private let mediaHolderView : UIView = {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.confiqureCell()
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        // Adding all the views as labels and image
        addSubview(contentHolderView)
        addSubview(mediaHolderView)
                
        // set a border and corner radius on comntent view
        contentHolderView.layer.borderWidth = 1.0
        contentHolderView.layer.borderColor = AppColors.lightGrayColor.cgColor
        contentHolderView.layer.cornerRadius = 10.0
        contentHolderView.clipsToBounds = true
        
        // Apply constraint on views
        self.applyConatrainsOnViews()
    }
    
    // Method to apply constraint on all the UIViews element
    func applyConatrainsOnViews() {
        contentHolderView.translatesAutoresizingMaskIntoConstraints = false
        contentHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        contentHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        contentHolderView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        contentHolderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        mediaHolderView.translatesAutoresizingMaskIntoConstraints = false
        mediaHolderView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        mediaHolderView.heightAnchor.constraint(equalToConstant: 90).isActive = true

        mediaHolderView.addSubview(img)
        mediaHolderView.clipsToBounds = true

        img.translatesAutoresizingMaskIntoConstraints = false
        img.leadingAnchor.constraint(equalTo: mediaHolderView.leadingAnchor, constant: 10).isActive = true
        img.topAnchor.constraint(equalTo: mediaHolderView.topAnchor, constant: 0).isActive = true
        img.bottomAnchor.constraint(equalTo: mediaHolderView.bottomAnchor, constant: 0).isActive = true
        img.rightAnchor.constraint(equalTo: mediaHolderView.rightAnchor, constant: 0).isActive = true
        img.clipsToBounds = true
        
        let subStackView = UIStackView.init(arrangedSubviews: [lblTitle,lblDescription])
        subStackView.backgroundColor = .red
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        subStackView.axis = .vertical
        subStackView.distribution = .fill
        subStackView.spacing = 10
        subStackView.alignment = .top
        subStackView.isLayoutMarginsRelativeArrangement = true
        subStackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)

        let stackView = UIStackView.init(arrangedSubviews: [mediaHolderView, subStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 10
        contentHolderView.addSubview( stackView)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
        
        stackView.centerXAnchor.constraint(equalTo: contentHolderView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentHolderView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: contentHolderView.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentHolderView.heightAnchor).isActive = true
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
    
    // Method to confiqure the cell
    func confiqureCell() {
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
//        self.applyConatrainsOnViews()
    }
}
