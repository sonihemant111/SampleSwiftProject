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
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.confiqureCell()
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
        // set background color of image
        self.img.backgroundColor = AppColors.lightGrayColor
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
