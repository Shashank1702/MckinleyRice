//
//  LoginModel.swift
//  MckinleyRice
//
//  Created by Trivial-5 on 12/2/19.
//  Copyright © 2019 Trivial-5. All rights reserved.
//

import Foundation

class User: CustomStringConvertible {
    
    var token:String?
    init() {}
    
    init(token: String)
    {
        self.token = token
    }
    var description: String {
        return "User --> token:\(token ?? "")"
    }
}
