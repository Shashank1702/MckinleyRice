//
//  ViewController.swift
//  MckinleyRice
//
//  Created by Trivial-5 on 12/2/19.
//  Copyright © 2019 Trivial-5. All rights reserved.
//

import UIKit
import HCHTTPService
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idTextF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!{
        didSet{
            loginBtn.layer.cornerRadius = 6
            loginBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 230/255.0, blue: 193/255.0, alpha: 1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView(){
        presentView(view: idView)
        presentView(view: passwordView)
    }
    
    func presentView(view: UIView){
        
        view.layer.cornerRadius = 0
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func loginAction(_ sender: UIButton) {
        
        if idTextF.text != "" && passwordF.text != ""{
            
            Network.shared.login(email: idTextF.text ?? "", password: passwordF.text ?? "", success: loginSuccess, failure: loginFailure)
            
        }else{
            let alert = UIAlertController(title: "Login", message: "Please enter the fileds.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //mark: login success--
    func loginSuccess(_ returnObject:Any) -> Void{
        
       
        print("----loginSuccess----")
        _ = Parser.parseUserData(JSONData: returnObject as? Data)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "WebKitController") as! WebKitController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //mark: login failure---
    func loginFailure(_ returnObject:Any?, _ statusCode:Int) -> Void {
        print("loginFailure")
    }
}

