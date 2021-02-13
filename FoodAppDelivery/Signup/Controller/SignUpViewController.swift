//
//  SingUpViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var phoneNo: String = ""
    var phoneCountryCode: String = ""
    var OTP: String = ""
    var dataSource = SignUpDataModel()
    var signUpView = SignUpView()
    var dataArray : [Field]?
    var viewArr : [UIView]? = []
  
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signUpLbl: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getSignUpFields()

        btnNext.setTitle("CONTINUE".localized(), for: .normal)

        signUpLbl.font = MuliFontBook.Bold.of(size: 14)
        btnNext.titleLabel?.font = MuliFontBook.SemiBold.of(size: 14)
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
                if let textField = view1 as? UITextField
                {
                    print((textField.text!))
                   
                    if self.dataArray![i].fieldKey == "mobileNumber"
                    {
                        dict.updateValue(phoneNo, forKey: (self.dataArray![i].fieldKey)!)
                    }
                    else
                    {
                        dict.updateValue((textField.text!), forKey: (self.dataArray![i].fieldKey)!)
                    }
                    i = i + 1
                }
            }
        }
        
        print("final Dict", dict)
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


extension SignUpViewController
{
    func getSignUpFields()
    {
        dataSource.requestData(success: {
            
            (SignUP) in
            
            let status = SignUP.error
            
            if status == "false"
            {
                if let data = SignUP.signupFields
                {
                    UserDefaults.standard.setSignUpDetails(value: data)
                }
                
                let data = SignUP.signupFields?[0]
                self.signUpLbl.text = data?.pageName
                self.dataArray = data?.fields
                self.inputBuilder()
            }
            else{
                
            }
            
        }, failure: {
            (Error) in
            print(Error)
        })
    }
    
    
    func inputBuilder()
    {
        if let fieldData = self.dataArray
        {
            for i in 0..<fieldData.count
            {
                if fieldData[i].fieldType!.rawValue == "EDITTEXT"
                {
                    var textValue: String? = ""
                    var isPassword: String? = ""

                  
                    if fieldData[i].fieldKey == "mobileNumber"
                    {
                        textValue = self.phoneCountryCode + " " + phoneNo
                    }
                    
                    if fieldData[i].fieldKey == "password"
                    {
                        isPassword = "true"
                    }
                    
                    viewArr?.append(signUpView.viewWithTextField(lblName: fieldData[i].fieldName ?? "", txtFieldValue: textValue!, width: self.mainView.frame.width, isPassword: isPassword!))
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
    
    func validateFields(dict: [String: Any]?)
    {
        var fDict : [String: Any] = dict!
        dataSource.requestToValidateData(dict: fDict, success:
            { (JSON) in
                
                let status = JSON.error
                
                if status == "false"
                {
                    let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    let dvc = StoaryBoard.instantiateViewController(withIdentifier: "SignUpVertificationVC")as! SignUpVertificationViewController
                    dvc.finalDict  = fDict
                    dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(dvc, animated: true, completion: nil)
                }
                else
                {
                   self.showAlertError(messageStr: JSON.errorMessage!)
                }
                
        }, failure: {
            (error) in
            

            })
        
       
    }
}
