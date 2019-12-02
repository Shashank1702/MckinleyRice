import UIKit
import HCHTTPService
import SwiftyJSON

class Parser : NSObject {
    
    // MARK: - User
    static func parseUserData(JSONData: Data?) -> String?
    {
        let json:JSON = getJSONBodyFromData(JSONData)
        if json != JSON.null
        {
            print("\(json)")
            
            let token: String = json["token"].stringValue
            
            Network.shared.setAuthorisationToken(token)
            
            return token
        }
        return nil
    }
    
    static func getJSONBodyFromData(_ JSONData: Data?) -> JSON {
        let json:JSON = {
            do {
                if let jsonData = JSONData {
                    let jsonPart = try JSON(data: jsonData)
                    if jsonPart != JSON.null {
                        return jsonPart
                    }
                    return JSON()
                }
                return JSON()
            } catch _ {
                return JSON()
            }
        }()
        return json
    }
}
