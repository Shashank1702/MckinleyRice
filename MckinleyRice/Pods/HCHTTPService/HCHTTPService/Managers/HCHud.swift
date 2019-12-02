//
//  HCHud.swift
//
//  Created by Hypercube on 8/30/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import PKHUD

/// HCHud class for handling showing and hiding loading huds.
open class HCHud: NSObject, UIGestureRecognizerDelegate {
    
    // MARK: - Shared instance
    
    /// Shared (singleton) instance
    public static let shared: HCHud = {
        let instance = HCHud()
        
        // setup code
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        
        return instance
    }()
    
    // MARK: - HCHud methods
    
    /// Showing hud inside defined view
    ///
    /// - Parameters:
    ///   - type: Hud content type
    ///   - hideOnTouch: Defines if hud should be hidden on touch. Default value is false.
    ///   - insideView: UIView inside which hud will be presented and inside which it will be loading. Default is nil, and in that case Hud will be presented above all screen. By default, insideView is not set.
    public static func showHUD(type: HUDContentType, hideOnTouch: Bool = false, insideView:UIView? = nil)
    {
        if let view = insideView
        {
            HUD.show(type, onView: view)
        }
        else
        {
            HUD.show(type)
        }
        
        if hideOnTouch
        {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideHUD))
            PKHUD.sharedHUD.contentView.addGestureRecognizer(tap)
        }
    }
    
    /// Method for flashing hud
    ///
    /// - Parameters:
    ///   - type: Hud content type
    ///   - stayOn: Time during which hud will be shown. Default value is 0.0.
    ///   - hideOnTouch: Defines if hud should be hidden on touch. Default value is false.
    public static func flashHUD(type: HUDContentType, stayOn: Double = 0.0, hideOnTouch: Bool = false)
    {
        HUD.flash(type, delay: stayOn)
        if hideOnTouch
        {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideHUD))
            PKHUD.sharedHUD.contentView.addGestureRecognizer(tap)
        }
    }
    
    /// Method for hiding hud
    @objc public static func hideHUD()
    {
        HUD.hide(animated:true)
    }
}
