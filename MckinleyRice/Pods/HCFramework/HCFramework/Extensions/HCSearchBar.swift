//
//  HCString.swift
//
//  Created by Hypercube on 9/20/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

// MARK: - UISearchBar extension
extension UISearchBar {
    
    /// Setup search bar
    ///
    /// - Parameters:
    ///   - frame: Search bar frame
    ///   - backgroundColor: Background color
    ///   - textColor: Text color
    ///   - textFont: Text font
    ///   - placeHolderText: Placeholder text
    ///   - searchIcon: Search icon
    public func hcSetupSearchBar(frame: CGRect, backgroundColor : UIColor, textColor: UIColor, textFont: UIFont, placeHolderText: String, searchIcon:UIImage? = nil)
    {
        let textField = self.value(forKey: "searchField") as? UITextField
        if let searchIcon = searchIcon
        {
            let glassIconView = textField?.leftView as? UIImageView
            glassIconView?.image = searchIcon
        }
        textField?.frame = frame
        textField?.backgroundColor = backgroundColor
        textField?.textColor = textColor
        textField?.font = textFont
        textField?.contentHorizontalAlignment = .center
        textField?.contentVerticalAlignment  = .center
        
        textField?.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}

