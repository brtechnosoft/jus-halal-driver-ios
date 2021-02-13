//
//  SignUpBankDetailsViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 13/03/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class SignUpBankDetailsViewController: UIViewController {

    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    var dataSource = SignUpDataModel()
    var finalDict:[String:Any] = [:]
    var dataArray : [Field]?
    var viewArr : [UIView]? = []
    var signUpView = SignUpView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let signupData = UserDefaults.standard.getSignUpDetails()
        if let data = signupData
        {
            dataArray = data[2].fields
            signUpLbl.text = data[2].pageName
        }
        
        btnNext.setTitle("SIGNUP".localized(), for: .normal)
        
        signUpLbl.font = MuliFontBook.Bold.of(size: 14)
        btnNext.titleLabel?.font = MuliFontBook.SemiBold.of(size: 14)
        
        inputBuilder()
    }
    
    @IBAction func backAtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextAtn(_ sender: Any) {
        
        var dict = [String: Any]()
        
        var i : Int = 0
        
        for subview in mainView.subviews
        {
            for view1 in subview.subviews
            {
                if let textField = view1 as? UITextField  //view1.isKind(of: UITextField.self)
                {
                    print((textField.text!))
                    
                    dict.updateValue((textField.text!), forKey: (self.dataArray![i].fieldKey)!)
                    i = i + 1
                }
            }
        }
       validateFields(dict: dict)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SignUpBankDetailsViewController
{
    
    func inputBuilder()
    {
        if let fieldData = self.dataArray
        {
            for i in 0..<fieldData.count
            {
                if fieldData[i].fieldType!.rawValue == "EDITTEXT"
                {
                    viewArr?.append(signUpView.viewWithTextField(lblName: fieldData[i].fieldName ?? "", txtFieldValue: "", width: self.mainView.frame.size.width, isPassword: ""))
                }
            }
        }
        setViewWithConstraints()
    }
    
    
    func setViewWithConstraints()
    {
        var height = 0.0
    
        for i in 0..<viewArr!.count
        {
            var topView = UIView()
    
            let currentView = viewArr![i]
    
            self.mainView.addSubview(currentView)
            currentView.translatesAutoresizingMaskIntoConstraints = false
    
            let margins = mainView.layoutMarginsGuide
    
            if i >= 1
            {
                topView = viewArr![i-1]
                let margins = topView.layoutMarginsGuide
                currentView.topAnchor.constraint(equalTo: margins.bottomAnchor, constant: 20).isActive = true
            }
            else
            {
                currentView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
            }
    
            currentView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
            currentView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
            currentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
            height = height + 80
    
        }
    
        mainViewHeight.constant = CGFloat(height)
        scrollView.contentSize.height = CGFloat(height) + 50
    }
    
    func validateFields(dict: [String: Any])
    {
        dataSource.requestToValidateData(dict: dict, success:
            { (JSON) in
                
                let status = JSON.error
                
                if status == "false"
                {
                    var fDict : [String: Any] = dict
                    fDict.updateValue(UserDefaults.standard.getCountryCode(), forKey: "countryCode")
                    self.finalDict = self.finalDict.merging(fDict, uniquingKeysWith: {(current, _) in current})
                    self.signUpAUser(dict : self.finalDict)
                }
                else
                {
                    self.showAlertError(messageStr: JSON.errorMessage!)
                }
                
        }, failure: {
            (error) in
            
        })
    }
    
    func signUpAUser(dict : [String:Any])
    {

        dataSource.requestToSignUpUser(dict: dict, success: {
            (UserSignUp) in
            
            let status = UserSignUp.error
            
            if status == "false"
            {
                let presentedVC = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNumberViewController") as! PhoneNumberViewController
                self.present(presentedVC, animated: false, completion: nil)
            }
            else{
                self.showAlertError(messageStr: UserSignUp.errorMessage!)
            }
            
        }, failure:{
            (Error) in
            
        })
    }
    
}
