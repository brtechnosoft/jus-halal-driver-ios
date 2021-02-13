//
//  LoginViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 08/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var accountDescLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    var dataSource = CredentialsViewModel()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLbl.text = "EAT WELL FEEL WELL".localized()
        accountLbl.text = "ACCOUNT".localized()
        accountDescLbl.text = "Login/Create Account quickly to manage orders".localized()
        titleLbl.text = "EAT WELL FEEL WELL".localized()
        loginBtn.setTitle("LOGIN".localized(),for: .normal)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginAtn(_ sender: Any) {
        
        dataSource.requestData(success: {
            (LoginSetting) in
            
            guard let status = LoginSetting.error else
            {
                return
            }
            if status == "false"
            {
                guard let isPassword = LoginSetting.isPassword else{
                    return
                }
                
                guard let MapKey = LoginSetting.browserKey else{
                    return
                }
                
                let termsURL = LoginSetting.termsAndConditions
                let currency = LoginSetting.currency
                UserDefaults.standard.setTermsURL(value: termsURL!)
                UserDefaults.standard.setMapKey(value: MAP_KEY)
                UserDefaults.standard.setCurrency(value: currency!)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.initiateGMSService()
                
                let presentedVC = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNumberViewController") as! PhoneNumberViewController
                UserDefaults.standard.setOTPOrPassword(value: isPassword)
                
                self.present(presentedVC, animated: false, completion: nil)
                
            }
        }, failure: {
            (Eror) in
            
        
        })
    }
    
    

}
