//
//  OTPVerificationViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 11/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class OTPVerificationViewController: UIViewController {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var phoneNoLbl: UILabel!
    
    @IBOutlet weak var firstTxtFdl: UITextField!
    @IBOutlet weak var secondTxtFdl: UITextField!
    @IBOutlet weak var thirdTxtFdl: UITextField!
    @IBOutlet weak var fourthTxtFdl: UITextField!
    @IBOutlet weak var fifthTxtFdl: UITextField!
    @IBOutlet weak var sixthTxtFdl: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorViewTopConstant: NSLayoutConstraint!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    
    let linearBar: LinearProgressBar = LinearProgressBar()
    let sharedInstance = Connection()
    var phoneNo = ""
    var otpOrPassword = ""
    var userStatus = ""
    var timeDelayForResendOTP = ""
    var phoneCountrycode = ""
    
    var counterTimer = 0
    var timer = Timer()
    var isAnimation = true
    
    let dataSource = CredentialsViewModel()
    
    @IBOutlet weak var errorLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setTimer()
        
        topLbl.text = "OTP".localized()
        verifyBtn.setTitle("VERIFY AND PROCEED".localized(),for: .normal)
        phoneNoLbl.text = "\("OTP Sent to".localized()) \(phoneNo)"
        
        firstTxtFdl.delegate = self
        secondTxtFdl.delegate = self
        thirdTxtFdl.delegate = self
        fourthTxtFdl.delegate = self
        fifthTxtFdl.delegate = self
        sixthTxtFdl.delegate = self
        
        firstTxtFdl.keyboardType = .numberPad
        secondTxtFdl.keyboardType = .numberPad
        thirdTxtFdl.keyboardType = .numberPad
        fourthTxtFdl.keyboardType = .numberPad
        fifthTxtFdl.keyboardType = .numberPad
        sixthTxtFdl.keyboardType = .numberPad
        
        firstTxtFdl.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        secondTxtFdl.addTarget(self, action: #selector(textFieldDidChange(_:)),
                               for: UIControl.Event.editingChanged)
        thirdTxtFdl.addTarget(self, action: #selector(textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        fourthTxtFdl.addTarget(self, action: #selector(textFieldDidChange(_:)),
                               for: UIControl.Event.editingChanged)
        fifthTxtFdl.addTarget(self, action: #selector(textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        sixthTxtFdl.addTarget(self, action: #selector(textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        
        configureLinearProgressBar(linearBar: linearBar)
        progressView.addSubview(linearBar)
        progressView.isHidden = true
       // hideKeyboardWhenTappedAround()
        
        //self.view.bringSubview(toFront: errorView)
        errorViewTopConstant.constant = -64
        errorView.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        errorViewTopConstant.constant = -64
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        linearBar.frame = CGRect(x: 0, y: 0, width: progressView.frame.size.width, height: 3)
        firstTxtFdl.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        errorView.isHidden = true
        
        firstTxtFdl.resignFirstResponder()
        secondTxtFdl.resignFirstResponder()
        thirdTxtFdl.resignFirstResponder()
        fourthTxtFdl.resignFirstResponder()
        fifthTxtFdl.resignFirstResponder()
        sixthTxtFdl.resignFirstResponder()
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
            closeError()
    }
    
    @IBAction func verifyAtn(_ sender: Any) {
        
        if firstTxtFdl.text != "" && secondTxtFdl.text != "" && thirdTxtFdl.text != "" && fourthTxtFdl.text != "" && fifthTxtFdl.text != "" && sixthTxtFdl.text != ""
        {
            self.showLoading()
            
            let add = ((((firstTxtFdl.text! + secondTxtFdl.text!) + (thirdTxtFdl.text!)) + (fourthTxtFdl.text!)) + (fifthTxtFdl.text!))
            
            let otp = add + (sixthTxtFdl.text!)
            
            
            dataSource.requestStaffOTPLogin(phoneNumber: phoneNo, countryCode: phoneCountrycode , OTP: otp, success:
                {
        
                    (UserLogin) in
                    
                    self.stopLoading()
                    
                    guard let status = UserLogin.error else
                    {
                        return
                    }
                    
                    if status == "false"
                    {
                        guard let isOTPVerified = UserLogin.otpVerified else{
                            return
                        }
                        
                        if isOTPVerified == "true"
                        {
                            guard let isNewUser = UserLogin.isNewDeliveryStaff else{
                                return
                            }
                            if isNewUser == "true"
                            {
                                
                                let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                                let dvc = StoaryBoard.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
                                dvc.phoneNo = self.phoneNo
                                dvc.phoneCountryCode = self.phoneCountrycode
                                dvc.OTP = otp
                                dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                self.present(dvc, animated: true, completion: nil)
                            }
                            else{
                                
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
                                
                                let setToken = "Bearer \(token)"
                                
                                UserDefaults.standard.setLoggedIn(value: true)
                                UserDefaults.standard.setAccessToken(value: setToken)
                                UserDefaults.standard.setUserID(value: String(userID))
                                UserDefaults.standard.setEmailID(value: emailID)
                                UserDefaults.standard.setMobileNo(value: self.phoneNo)
                                
                                let StoaryBoard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
                                let dvc = StoaryBoard.instantiateViewController(withIdentifier: "MainTabBarViewController")as! MainTabBarViewController
                                self.present(dvc, animated: true, completion: nil)
                                
                            }
                        }
                    }
                    else
                    {
                        guard let errorStatus = UserLogin.errorMessage else
                        {
                            return
                        }
                        // self.showAlertError(messageStr: errorStatus)
                        self.errorLbl.text = errorStatus
                        self.showError()
                        
                    }
            },
                              failure:
                {
                    (Error) in
                    self.stopLoading()
                    //self.showAlertError(messageStr: Error.localizedDescription)
                    self.errorLbl.text = Error.localizedDescription
                    self.showError()
            })
        }
        else
        {
            if isAnimation == true
            {
                errorLbl.text = "Please enter valid OTP".localized()
                self.verifyBtn.buttonShake()
                showError()
            }
        }
    }
    
    @IBAction func resendAtn(_ sender: Any) {
         
            self.showLoading()
        
            dataSource.requestResendOTP(phoneNo: phoneNo, countryCode: self.phoneCountrycode, success:
            {
                    (ForgetPassword) in
                    
                    self.stopLoading()
                    
                    guard let status = ForgetPassword.error else
                    {
                        return
                    }
                    
                    if status == "false"
                    {
                        self.setTimer()
                        let otpNumber = ForgetPassword.otpNumber!

                        startLocalNotification(otp: String(otpNumber))
                    }
                    else
                    {
                        guard let errorStatus = ForgetPassword.error_message else
                        {
                            return
                        }
                        // self.showAlertError(messageStr: errorStatus)
                        self.errorLbl.text = errorStatus
                        self.showError()
                    }
            },
                                  failure:
                {
                    (Error) in
                    self.stopLoading()
                    // self.showAlertError(messageStr: Error.localizedDescription)\
                    self.errorLbl.text = Error.localizedDescription
                    self.showError()
            })
            
    
        
    }
    
    @IBAction func backAtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        let text = textField.text
        
        if (text?.count)! == 1
        {
            switch textField
            {
            case firstTxtFdl:
                secondTxtFdl.becomeFirstResponder()
            case secondTxtFdl:
                thirdTxtFdl.becomeFirstResponder()
            case thirdTxtFdl:
                fourthTxtFdl.becomeFirstResponder()
            case fourthTxtFdl:
                fifthTxtFdl.becomeFirstResponder()
            case fifthTxtFdl:
                sixthTxtFdl.becomeFirstResponder()
            case sixthTxtFdl:
                sixthTxtFdl.resignFirstResponder()
            default:
                break
            }
        }
        else if (text?.count)! == 0
        {
            switch textField
            {
            case firstTxtFdl:
                firstTxtFdl.becomeFirstResponder()
            case secondTxtFdl:
                firstTxtFdl.becomeFirstResponder()
            case thirdTxtFdl:
                secondTxtFdl.becomeFirstResponder()
            case fourthTxtFdl:
                thirdTxtFdl.becomeFirstResponder()
            case fifthTxtFdl:
                fourthTxtFdl.becomeFirstResponder()
            case sixthTxtFdl:
                fifthTxtFdl.becomeFirstResponder()
            default:
                break
            }
        }
        
    }
}


extension OTPVerificationViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        let tempString = String(newString)
        
        if newString.length > 1
        {
            switch textField
            {
            case firstTxtFdl:
                secondTxtFdl.text = String(tempString.last!)
                secondTxtFdl.becomeFirstResponder()
            case secondTxtFdl:
                thirdTxtFdl.text = String(tempString.last!)
                thirdTxtFdl.becomeFirstResponder()
            case thirdTxtFdl:
                fourthTxtFdl.text = String(tempString.last!)
                fourthTxtFdl.becomeFirstResponder()
            case fourthTxtFdl:
                fifthTxtFdl.text = String(tempString.last!)
                fifthTxtFdl.becomeFirstResponder()
            case fifthTxtFdl:
                sixthTxtFdl.text = String(tempString.last!)
                sixthTxtFdl.becomeFirstResponder()
            case sixthTxtFdl:
                sixthTxtFdl.resignFirstResponder()
            default:
                break
            }
        }
        return newString.length <= maxLength
    }
    

}

extension OTPVerificationViewController
{
    
    func showError()
    {
        
        errorView.isHidden = false
        isAnimation = false
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.errorViewTopConstant.constant = 0
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                self.animationStop()
        })
        
    }
    
    @objc func closeError()
    {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.errorViewTopConstant.constant = -64
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                self.isAnimation = true
        })
    }
    
    func animationStop()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:
            {
                self.closeError()
        })
    }
    
    func showLoading()
    {
        progressView.isHidden = false
        self.linearBar.startAnimation()
        verifyBtn.isUserInteractionEnabled = false
    }
    
    func stopLoading()
    {
        progressView.isHidden = true
        self.linearBar.stopAnimation()
        verifyBtn.isUserInteractionEnabled = true
    }
    
    
    func setTimer()
    {
        self.resendBtn.isHidden = true
        self.resendLbl.isHidden = false
        self.counterTimer = Int(timeDelayForResendOTP)!
        let strTime = timeString(time: TimeInterval(counterTimer))
        let strCounterTimer = String(describing: strTime)
        let strMsgResend = "Resend code in ".localized() + strCounterTimer + "m"
        resendLbl.text = strMsgResend
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateResendOTP), userInfo: nil, repeats: true)
    }
    
    @objc func updateResendOTP()
    {
        
        counterTimer -= 1
        if counterTimer < 1
        {
            resendBtn.isHidden = false
            resendLbl.isHidden = true
            timer.invalidate()
        }
        else
        {
            resendBtn.isHidden = true
            resendLbl.isHidden = false
            let strTime = timeString(time: TimeInterval(counterTimer))
            let strCounterTimer = String(describing: strTime)
            let strMsgResend = "Resend code in ".localized() + strCounterTimer + "m"
            resendLbl.text = strMsgResend
        }
    }
    
}
