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
        contentHolderView.addSubview(img)
        contentHolderView.addSubview(lblDescription)
        contentHolderView.addSubview(lblTitle)
        
        self.applyConatrainsOnViews()
//        lblTitle.backgroundColor = UIColor.red
//        lblDescription.backgroundColor = UIColor.yellow
//        contentHolderView.backgroundColor = UIColor.green
//        self.backgroundColor = UIColor.systemPink
        
        // set a border and corner radius on comntent view
        contentHolderView.layer.borderWidth = 1.0
        contentHolderView.layer.borderColor = AppColors.lightGrayColor.cgColor
        contentHolderView.layer.cornerRadius = 10.0
    }
    
    // Method to apply constraint on all the UIViews element
    func applyConatrainsOnViews() {
        // Applying constraints on the views
        contentHolderView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        contentHolderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 110).isActive = true
        
        // Applying constraints on the views
        img.anchor(top: contentHolderView.topAnchor, left: contentHolderView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        
        lblTitle.anchor(top: contentHolderView.topAnchor, left: img.rightAnchor, bottom: nil, right: contentHolderView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0, enableInsets: false)
        lblTitle.setContentHuggingPriority(.defaultHigh, for:.vertical)
        
        
        lblDescription.anchor(top: lblTitle.bottomAnchor, left: lblTitle.leftAnchor, bottom: contentHolderView.bottomAnchor, right: lblTitle.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
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
        let imgUrl = URL(string: objCountryData.image ?? "")
        img.kf.setImage( with: imgUrl, placeholder: #imageLiteral(resourceName: "placeholderImage"))
        
        lblTitle.text = objCountryData.title?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized ?? "Not available"
        lblDescription.text = objCountryData.description?.trimmingCharacters(in: .whitespacesAndNewlines).capitalizingFirstLetter() ?? "Not available"
        
        self.selectionStyle = .none
    }
}
