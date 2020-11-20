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
 
    // For No data found cases
    enum NoDataFoundCase {
        case noData
    }
    
    // MARK: - settingEmptyDataSet method
    //=================================
    func settingEmptyDataSet(placeholder: String, placeholderTV: UITableView, isLargeText: Bool = false, emptyDataState: NoDataFoundCase = NoDataFoundCase.noData) {
        
        let myAttribute = [NSAttributedString.Key.font:  AppFonts.HelveticaBold.withSize(isLargeText ? 17: 14),
        NSAttributedString.Key.foregroundColor: AppColors.lightGrayColor]
        
        var message = ""
        switch emptyDataState {
        case .noData:
            message = "No Data Found"
        }
        
        let stringPlaceholder = NSAttributedString(string: "\n\(message)\n\n\n", attributes: myAttribute)
        
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
