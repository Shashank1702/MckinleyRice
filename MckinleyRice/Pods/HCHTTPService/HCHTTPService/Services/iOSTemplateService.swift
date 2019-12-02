//
//  iOSTemplateService.swift
//
//  Created by Hypercube on 12/16/16.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import Foundation
import UIKit

class iOSTemplateService {

    private var hcService : HCService! = nil
    
    static let shared: iOSTemplateService = {
        
        let instance = iOSTemplateService()
        
        instance.hcService = HCService.shared

        return instance
    }()
    
    // MARK: - Authorisation
    
    /// Set Authorisation Token
    ///
    /// - Parameter token: Authorisation Token.
    func setAuthorisationToken(_ token: String)
    {
        hcService.token = token
    }
}
