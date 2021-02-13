//
//  PhoneNumberViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 08/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {

    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var loginDescLbl: UILabel!
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var phoneNoTxtFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var errorViewTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errorView: UIView!
    let linearBar: LinearProgressBar = LinearProgressBar()
    var isRequested = false
    
    var dataSource = CredentialsViewModel()

    var selectedCountry: Country!
    var isAnimation = true
    
    var isOtpOrPassword : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLbl.text = "LOGIN".localized()
        loginDescLbl.text = "Enter your phone number to proceed".localized()
        phoneNoLbl.text = "PHONE NUMBER".localized()
        loginBtn.setTitle("LOGIN".localized(),for: .normal)
        errorLbl.text = "Please enter valid phone number".localized()
        phoneNoTxtFld.delegate = self
        //        linearBar.frame = CGRect(x: 0, y: progressView.frame.origin.y, width: 150, height: 3) //progressView.frame
        
        configureLinearProgressBar(linearBar: linearBar)
        progressView.addSubview(linearBar)
        progressView.isHidden = true
        
        // hideKeyboardWhenTappedAround()
        
        countryCodeView.isHidden = true
        self.bgView.isHidden = true
        
        countryCodeView.layer.cornerRadius = 5.0
        countryCodeView.clipsToBounds = true
        
        isOtpOrPassword = UserDefaults.standard.getOTPOrPassword()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        errorView.isHidden = true
        errorViewTopConstraints.constant = -64
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        phoneNoTxtFld.becomeFirstResponder()
        
        linearBar.frame = CGRect(x: 0, y: 0, width: progressView.frame.size.width, height: 3)
        
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
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

    @IBAction func closeAtn(_ sender: Any) {
        
    }
    
    @IBAction func dismissbgView(_ sender: Any) {
        
        self.bgView.isHidden = true
        self.countryCodeView.hideCountryView()
        
    }
    
    @IBAction func countryCodeAtn(_ sender: Any) {
        
        phoneNoTxtFld.resignFirstResponder()
        
        self.bgView.isHidden = false
        
        let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = StoaryBoard.instantiateViewController(withIdentifier: "countryCodeVC") as! SRCountryPickerController
        self.addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.countryCodeView.frame.size.width, height: self.countryCodeView.frame.size.height)
        vc.countryDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.countryCodeView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        self.countryCodeView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.countryCodeView.showCountryView()
        
    }
    
    @IBAction func loginAtn(_ sender: Any)
    {
        progressView.isHidden = true
        if (phoneNoTxtFld.text?.count)! >= 7 && (phoneNoTxtFld.text?.count)! <= 15
        {
            if !isRequested
            {
                self.showLoading()
                self.isRequested = true
               
                dataSource.requestToCheckAvailability(phoneNumber: phoneNoTxtFld.text!, countryCode: countryCodeLbl.text!, success:
                    {
                        (CheckAvailability) in
                        
                        self.stopLoading()
                        self.isRequested = false
                        
                        guard let status = CheckAvailability.error, let isNewUser = CheckAvailability.isNewDeliveryStaff
                            else
                        {
                            return
                        }
                        
                        var timeDelay = "0"
                        
                        if CheckAvailability.timeDelayForOtp != nil
                        {
                            timeDelay = CheckAvailability.timeDelayForOtp!
                        }
                        
                        if status == "false"
                        {
                            if isNewUser == "true" || self.isOtpOrPassword == "false"
                            {
                                if CheckAvailability.otpNumber != nil
                                {
                                    let otpNumber = CheckAvailability.otpNumber!
                                    startLocalNotification(otp: String(describing: otpNumber))
                                }
                                
                                let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                                let dvc = StoaryBoard.instantiateViewController(withIdentifier: "OTPVerificationViewController")as! OTPVerificationViewController
                                dvc.phoneNo = self.phoneNoTxtFld.text!
                                dvc.otpOrPassword = self.isOtpOrPassword
                                dvc.userStatus = isNewUser
                                dvc.timeDelayForResendOTP = timeDelay
                                dvc.phoneCountrycode = self.countryCodeLbl.text!
                                UserDefaults.standard.setCountryCode(value: self.countryCodeLbl.text!)
                                dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                self.present(dvc, animated: true, completion: nil)
                            }
                            else
                            {
                                let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                                let dvc = StoaryBoard.instantiateViewController(withIdentifier: "PasswordViewController")as! PasswordViewController
                                dvc.phoneNo = self.phoneNoTxtFld.text!
                                dvc.phoneCountryCode = self.countryCodeLbl.text!
                                dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                self.present(dvc, animated: true, completion: nil)
                            }
                        }
                        
                },
                                 failure:
                    {
                        (Error) in
                        
                        self.stopLoading()
                        self.isRequested = false
                        self.errorLbl.text = Error.localizedDescription
                        self.showError()
                })
            }
        }
        else
        {
            errorView.isHidden = false
            
            if self.isAnimation == true
            {
                
                print("isAnimation False")
                
                self.loginBtn.buttonShake()
                errorLbl.text = "Please enter valid phone number".localized()
                showError()
                
            }
        }
    }
    
    func animationStop()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:
            {
                self.closeError()
        })
    }
    
    
}

extension PhoneNumberViewController
{
    
    func showLoading()
    {
        progressView.isHidden = false
        self.linearBar.startAnimation()
        loginBtn.isUserInteractionEnabled = false
    }
    
    func stopLoading()
    {
        progressView.isHidden = true
        self.linearBar.stopAnimation()
        loginBtn.isUserInteractionEnabled = true
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
                print("isAnimation True")
                
        })
    }
    
    @objc func showError(){
        
        self.isAnimation = false
        
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
    
}

extension PhoneNumberViewController: CountrySelectedDelegate {
    
    func SRcountrySelected(countrySelected country: Country) {
        
        self.bgView.isHidden = true
        self.countryCodeView.isHidden = true
        
        self.selectedCountry = country
        print("country selected  code \(self.selectedCountry.country_code), country name \(self.selectedCountry.country_name), dial code \(self.selectedCountry.dial_code)")
        
        self.countryCodeLbl.text = (self.selectedCountry.dial_code)
    }
    
}

extension PhoneNumberViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        guard newString.length > maxLength else
        {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
}
