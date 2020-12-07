//
//  UIVIewController+Extension.swift
//  TestProject
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import EmptyDataSet_Swift

extension UIViewController {
    
    // MARK: - settingEmptyDataSet method
    //=================================
    func settingEmptyDataSet(placeholderMessage: String, placeholderTV: UITableView, isLargeText: Bool = false) {
        
        let myAttribute = [NSAttributedString.Key.font:  AppFonts.HelveticaBold.withSize(isLargeText ? 17: 14),
        NSAttributedString.Key.foregroundColor: AppColors.lightGrayColor]
        
        let stringPlaceholder = NSAttributedString(string: "\n\(placeholderMessage)\n\n\n", attributes: myAttribute)
        
        placeholderTV.emptyDataSetView { view in
            view.titleLabelString(stringPlaceholder)
                //.image(UIImage(named: "icEmptyStateNodata"))
                .isScrollAllowed(true)
                .isImageViewAnimateAllowed(true)
                .didTapDataButton {
                    // Do nothing
            }
            .didTapContentView {
                // Do nothing
            }
        }
    }
    
}
