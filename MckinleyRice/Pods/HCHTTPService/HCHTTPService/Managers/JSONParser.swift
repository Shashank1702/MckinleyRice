//
//  JSONParser.swift
//
//  Created by Hypercube on 12/19/16.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import Foundation
import SwiftyJSON

open class JSONParser {

    // MARK: - ERROR
    public static func parseError(JSONData: Data?)
    {
        do
        {
            if let JSONData = JSONData
            {
                let json = try JSON(data: JSONData)
                print(json)
            }
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    public static func parseError(JSONString: String?)
    {
        if let dataFromString = JSONString!.data(using: .utf8, allowLossyConversion: false) {
            
            let json:JSON = {
                do {
                    return try JSON(data: dataFromString)
                }
                catch let error
                {
                    print(error.localizedDescription)
                    return JSON()
                }
            }()
            
            print(json)
        }
    }
}
