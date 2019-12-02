import Foundation
import HCHTTPService
import HCFramework
import Alamofire

class Network {
    
    //MARK: - Shared Instance
    private var hcService : HCService! = nil
    static let shared: Network = {
        
        HCService.timeoutIntervalRequest = 300
        HCService.timeoutIntervalResource = 300
        
        let instance = Network()
        instance.hcService = HCService.shared
        
        return instance
    }()
    
    // MARK: - Authorisation
    func setAuthorisationToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        hcService.token = token
    }
    
    func removeAuthorisationToken() {
        UserDefaults.standard.set(nil, forKey: "token")
        hcService.token = ""
    }
    
    func getAuthorisationToken() -> String {
        if hcService.token.isEmpty  {
            if let userToken = UserDefaults.standard.object(forKey: "token") as? String {
                return userToken
            } else {
                return ""
            }
        } else {
            return hcService.token
        }
    }
    
    
    // MARK: - Access
    func login(email: String, password: String, success:@escaping(Any) -> Void, failure:@escaping (Any?, Int) -> Void)
    {
        hcService.requestWithURL("https://reqres.in", path: "/api/login", methodType: .post, params: ["email":email as AnyObject,"password":password as AnyObject], header: nil,  success: success, failure: failure)
    }
    
}

