//
//  PasswordViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 11/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var loginDescLbl: UILabel!
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var phoneNoTxtFld: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTxtFdl: UITextField!
    @IBOutlet weak var forgotPwdBtn: UIButton!
    @IBOutlet weak var enterPwdBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errorViewTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var errorView: UIView!
    let dataSource = CredentialsViewModel()
    
    let linearBar: LinearProgressBar = LinearProgressBar()
    let sharedInstance = Connection()
    var phoneNo = ""
    var isAnimation = true
    var phoneCountryCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginLbl.text = "LOGIN".localized()
        loginDescLbl.text = "Enter your phone number to proceed".localized()
        phoneNoLbl.text = "PHONE NUMBER".localized()
        
        enterPwdBtn.setTitle("LOGIN".localized(),for: .normal)
        passwordLbl.text = "Password".localized()
        
        forgotPwdBtn.setTitle("FORGOT PASSWORD?".localized(),for: .normal)
        phoneNoTxtFld.text = phoneNo
        countryCodeLbl.text = phoneCountryCode
        phoneNoTxtFld.isUserInteractionEnabled = false
        
        configureLinearProgressBar(linearBar: linearBar)
        progressView.addSubview(linearBar)
        progressView.isHidden = true
        
        hideKeyboardWhenTappedAround()
        errorViewTopConstraints.constant = -64
        errorView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        errorViewTopConstraints.constant = -64
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        linearBar.frame = CGRect(x: 0, y: 0, width: progressView.frame.size.width, height: 3) //progressView.frame
        passwordTxtFdl.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        passwordTxtFdl.resignFirstResponder()
        errorView.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func animationStop()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:
            {
                self.closeError()
        })
    }
    
    
    @objc func closeError()
    {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.errorViewTopConstraints.constant = -64
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                self.isAnimation = true
                
        })
    }
    
    func showError(){
        
        errorView.isHidden = false
        isAnimation = false
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.errorViewTopConstraints.constant = 0
                self.view.layoutIfNeeded()
                
        },
                       completion:
            {
                (finished: Bool) in
                self.animationStop()
        })
    }
    
    @IBAction func editPhoneNoAtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func forgotPwdAtn(_ sender: Any) {
        
        self.showLoading()
        
        dataSource.requestForgetData(phoneNumber: phoneNo, phoneCountryCode: phoneCountryCode, success: {
            (ForgetPassword) in
            
            self.stopLoading()
            
            guard let status = ForgetPassword.error else
            {
                return
            }
            
            if status == "false"
            {
                
                guard let otpNumber = ForgetPassword.otpNumber, let timeDelayForOtp = ForgetPassword.timeDelayForOtp else
                {
                    return
                }
                
                startLocalNotification(otp: String(otpNumber))
                
                //                    self.view.window!.layer.add(presentRight(), forKey: kCATransition)
                let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let dvc = StoaryBoard.instantiateViewController(withIdentifier: "ForgotPasswordController")as! ForgotPasswordController
                dvc.phoneNo = self.phoneNoTxtFld.text!
                dvc.timeDelayForResendOTP = timeDelayForOtp
                dvc.phoneCountrycode = self.phoneCountryCode
                dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(dvc, animated: true, completion: nil)
            }
            else
            {
                guard let errorStatus = ForgetPassword.error_message else
                {
                    return
                }

                self.errorLbl.text = errorStatus
                self.showError()
            }
        },
           failure:{
                    (Error) in
                    self.stopLoading()

                    self.errorLbl.text = Error.localizedDescription
                    self.showError()
        })
        
    }
    
    @IBAction func enterPwdAtn(_ sender: Any) {
      
        progressView.isHidden = false
        self.linearBar.startAnimation()
        
        if passwordTxtFdl.text != ""
        {
            self.showLoading()
            
            dataSource.requestToLoginByPassword(PhoneNo: phoneNo, countryCode: phoneCountryCode, password: passwordTxtFdl.text!, success:
            {
            
                    (UserLogin) in
                    
                    self.stopLoading()
                    
                    guard let status = UserLogin.error else
                    {
                        return
                    }
                    
                    if status == "false"
                    {
                        guard let token = UserLogin.accessToken else
                        {
                            return
                        }

                        guard let userID = UserLogin.staffDetails?.id else
                        {
                            return
                        }

                        guard let emailID = UserLogin.staffDetails?.email else
                        {
                            return
                        }

                        guard let staffAvailableStatus = UserLogin.staffDetails?.status else
                        {
                            return
                        }

                        let setToken = "Bearer \(token)"

                        UserDefaults.standard.setLoggedIn(value: true)
                        UserDefaults.standard.setAccessToken(value: setToken)
                        UserDefaults.standard.setUserID(value: String(userID))
                        UserDefaults.standard.setEmailID(value: emailID)
                        UserDefaults.standard.setMobileNo(value: self.phoneNoTxtFld.text!)
                        UserDefaults.standard.setUserName(value: (UserLogin.staffDetails?.name)!)
                        UserDefaults.standard.setStaffAvailableStatus(value: staffAvailableStatus)

                        let StoaryBoard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
                        let dvc = StoaryBoard.instantiateViewController(withIdentifier: "MainTabBarViewController")as! MainTabBarViewController
                        self.present(dvc, animated: true, completion: nil)
                    }
                    else
                    {
                        guard let errorStatus = UserLogin.errorMessage else
                        {
                            return
                        }

                        self.errorLbl.text = errorStatus
                        self.showError()
                    }
            },
                             failure:
                {
                    (Error) in
                    self.stopLoading()
                    self.errorLbl.text = Error.localizedDescription
                    self.showError()
            })
        }
        else
        {
            
            if isAnimation == true
            {
                errorLbl.text = "Please enter valid password".localized()
                
                self.enterPwdBtn.shake()
                progressView.isHidden = true
                self.linearBar.stopAnimation()
                
                showError()
            }
        }
    }
    
    @IBAction func closeAtn(_ sender: Any) {
        closeError()
    }
}

extension PasswordViewController
{
    
    func showLoading()
    {
        progressView.isHidden = false
        self.linearBar.startAnimation()
        forgotPwdBtn.isUserInteractionEnabled = false
        enterPwdBtn.isUserInteractionEnabled = false
    }
    
    func stopLoading()
    {
        progressView.isHidden = true
        self.linearBar.stopAnimation()
        forgotPwdBtn.isUserInteractionEnabled = true
        enterPwdBtn.isUserInteractionEnabled = true
    }
    
}
