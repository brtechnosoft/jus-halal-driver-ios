//
//  ForgotPasswordController.swift
//  FoodAppUser
//
//  Created by Pyramidions on 13/10/18.
//  Copyright © 2018 Pyramidions. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ForgotPasswordController: UIViewController
{
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errorViewTopConstant: NSLayoutConstraint!
    @IBOutlet weak var forgotTopLbl: UILabel!
    @IBOutlet weak var thanksLbl: UILabel!
    @IBOutlet weak var confirmationLbl: UILabel!
    @IBOutlet weak var firstTxtFdl: UITextField!
    @IBOutlet weak var secondTxtFdl: UITextField!
    @IBOutlet weak var thirdTxtFdl: UITextField!
    @IBOutlet weak var fourthTxtFdl: UITextField!
    @IBOutlet weak var fifthTxtFdl: UITextField!
    @IBOutlet weak var sixthTxtFdl: UITextField!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var newPasswordTxtFdl: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTxtFdl: SkyFloatingLabelTextField!
    @IBOutlet weak var newPasswordLbl: UILabel!
    @IBOutlet weak var passwordSaveBtn: UIButton!
    @IBOutlet weak var passwordTopView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTopConstraint: NSLayoutConstraint!
    let linearBar: LinearProgressBar = LinearProgressBar()
    let sharedInstance = Connection()
    var phoneNo = ""
    var timeDelayForResendOTP = ""
    var phoneCountrycode = ""
    @IBOutlet var resendBtn: UIButton!
    @IBOutlet var resendLbl: UILabel!
    var isAnimation = true
    var counterTimer = 0
    var timer = Timer()
    var OTP = ""
    var dataSource = CredentialsViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setTimer()
        
        errorLbl.text = "Please enter valid OTP".localized()
        forgotTopLbl.text = "FORGOT PASSWORD".localized()
        thanksLbl.text = "Awesome , Thanks!".localized()
        confirmationLbl.text = "We have sent you a confirmation code via SMS. You should get it soon.".localized()
        verifyBtn.setTitle("VERIFY AND PROCEED".localized(),for: .normal)
        newPasswordLbl.text = "NEW PASSWORD".localized()
        passwordSaveBtn.setTitle("SAVE".localized(),for: .normal)
        resendLbl.text = ""
        
        newPasswordTxtFdl.placeholder = "New Password".localized()
        newPasswordTxtFdl.selectedLineColor = UIColor(hexString: "#FAD05B")
        confirmPasswordTxtFdl.placeholder = "Re-enter Password".localized()
        confirmPasswordTxtFdl.selectedLineColor = UIColor(hexString: "#FAD05B")
        
        
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
        
        firstTxtFdl.addTarget(self, action: #selector(ForgotPasswordController.textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        secondTxtFdl.addTarget(self, action: #selector(ForgotPasswordController.textFieldDidChange(_:)),
                               for: UIControl.Event.editingChanged)
        thirdTxtFdl.addTarget(self, action: #selector(ForgotPasswordController.textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        fourthTxtFdl.addTarget(self, action: #selector(ForgotPasswordController.textFieldDidChange(_:)),
                               for: UIControl.Event.editingChanged)
        fifthTxtFdl.addTarget(self, action: #selector(ForgotPasswordController.textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        sixthTxtFdl.addTarget(self, action: #selector(ForgotPasswordController.textFieldDidChange(_:)),
                              for: UIControl.Event.editingChanged)
        
        configureLinearProgressBar(linearBar: linearBar)
        progressView.addSubview(linearBar)
        progressView.isHidden = true
        hideKeyboardWhenTappedAround()
        
        passwordTopView.isHidden = true
        self.view.bringSubviewToFront(errorView)
        errorViewTopConstant.constant = -64
        errorView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        errorViewTopConstant.constant = -64
        passwordTopConstraint.constant = -250
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        linearBar.frame = CGRect(x: 0, y: 0, width: progressView.frame.size.width, height: 3)
        firstTxtFdl.becomeFirstResponder()
        errorView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        firstTxtFdl.resignFirstResponder()
        secondTxtFdl.resignFirstResponder()
        thirdTxtFdl.resignFirstResponder()
        fourthTxtFdl.resignFirstResponder()
        fifthTxtFdl.resignFirstResponder()
        sixthTxtFdl.resignFirstResponder()
        newPasswordTxtFdl.resignFirstResponder()
        confirmPasswordTxtFdl.resignFirstResponder()
    }
    
    @IBAction func back(_ sender: Any)
    {
        //        self.view.window!.layer.add(presentLeft(), forKey: kCATransition)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func verifyAtn(_ sender: Any)
    {
        
        if firstTxtFdl.text != "" && secondTxtFdl.text != "" && thirdTxtFdl.text != "" && fourthTxtFdl.text != "" && fifthTxtFdl.text != "" && sixthTxtFdl.text != ""
        {
            self.showLoading()
            
            let add = ((((firstTxtFdl.text! + secondTxtFdl.text!) + (thirdTxtFdl.text!)) + (fourthTxtFdl.text!)) + (fifthTxtFdl.text!))
            
            let otp = add + (sixthTxtFdl.text!)
            
            dataSource.requestToVertifyAnOTP(phoneNo: phoneNo ,phoneCountrycode: phoneCountrycode, otp: otp, success:
                {
                    (OtpVerification) in
                    
                    self.stopLoading()
                    
                    guard let status = OtpVerification.error else
                    {
                        return
                    }
                    
                    if status == "false"
                    {
                        self.showPasswordView()
                        self.OTP = otp
                    }
                    else
                    {
                        guard let errorStatus = OtpVerification.errorMessage else
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
                errorLbl.text = "Please enter valid OTP".localized()
                
                self.verifyBtn.buttonShake()
                isAnimation = false
                showError()
            }
        }
    }
    
    @IBAction func closeAtn(_ sender: Any)
    {
        closeError()
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
    
    @IBAction func passwordChangeAtn(_ sender: Any)
    {
        if newPasswordTxtFdl.text! == ""
        {
            errorLbl.text = "Please enter the new password".localized()
            showError()
        }
        else if confirmPasswordTxtFdl.text! == ""
        {
            errorLbl.text = "Please enter the confirm password".localized()
            showError()
        }
        else if confirmPasswordTxtFdl.text! != newPasswordTxtFdl.text!
        {
            errorLbl.text = "New password & Confirm password must be same".localized()
            showError()
        }
        else
        {
            closeError()
            
            self.showLoading()
            
            dataSource.requestPasswordChangeData(phoneNo: phoneNo, phoneCountrycode: phoneCountrycode, OTP: OTP, Password: newPasswordTxtFdl.text!, success:
                {
                    (ChangePassword) in
                    
                    guard let status = ChangePassword.error else
                    {
                        return
                    }
                    
                    if status == "false"
                    {
                        //                        let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                        //                        let dvc = StoaryBoard.instantiateViewController(withIdentifier: "PasswordViewController")as! PasswordViewController
                        //                        dvc.phoneNo = self.phoneNo
                        //                        dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        //                        self.present(dvc, animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    else
                    {
                        self.stopLoading()
                        
                        guard let errorStatus = ChangePassword.errorMessage else
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
    }
    
    @IBAction func closePasswordView(_ sender: Any)
    {
        hidePasswordView()
    }
    
    
    @IBAction func resendAtn(_ sender: Any) {
        
        self.showLoading()
        
        dataSource.requestResendOTP(phoneNo :phoneNo, countryCode :phoneCountrycode, success:
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
                    //self.showAlertError(messageStr: errorStatus)
                    
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
    
    
}

extension ForgotPasswordController : UITextFieldDelegate
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

extension ForgotPasswordController
{
    
    func showPasswordView()
    {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.passwordTopConstraint.constant = 0
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                self.passwordTopView.isHidden = false
        })
    }
    
    func hidePasswordView()
    {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.passwordTopConstraint.constant = -250
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                self.passwordTopView.isHidden = true
        })
    }
    
    func showError()
    {
        errorView.isHidden = false
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
        passwordSaveBtn.isUserInteractionEnabled = false
        verifyBtn.isUserInteractionEnabled = false
    }
    
    func stopLoading()
    {
        progressView.isHidden = true
        self.linearBar.stopAnimation()
        passwordSaveBtn.isUserInteractionEnabled = true
        verifyBtn.isUserInteractionEnabled = true
    }
    
    func setTimer()
    {
        self.resendBtn.isHidden = true
        self.resendLbl.isHidden = false
        resendLbl.text = "Resend code in ".localized()
        self.counterTimer = Int(timeDelayForResendOTP)!
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
