//
//  AccountViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 22/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var helpDescLbl: UILabel!
    var data: StaffProfile?
    
    @IBOutlet weak var btnLogOut: UIButton!
    
    let dataSource = AccountDataModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        helpLbl.text = "HELP".localized()
        helpDescLbl.text = "FAQs and Links".localized()
       
        btnLogOut.setTitle("LOGOUT".localized(), for: .normal)
        btnLogOut.layer.cornerRadius = 5
        
        getProfileData()
        setFont()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutAtn(_ sender: Any) {

        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let presentedVC = StoaryBoard.instantiateViewController(withIdentifier: "LoginCreateViewController") as! LoginViewController
        self.present(presentedVC, animated: false, completion: nil)
        
    }
    
    @IBAction func faqAtn(_ sender: Any) {
      
        let StoaryBoard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let dvc = StoaryBoard.instantiateViewController(withIdentifier: "HelpVC")as! HelpViewController
        dvc.webURL = "https://www.uberdoo.com/privacy-policy.html"
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    func getProfileData()
    {
        dataSource.requestToGetProfileData(success: {
            (JSON) in
            let status = JSON.error
            if status == "false"
            {
                self.data = JSON.staffProfile
                self.name.text = self.data?.name
                self.phoneNumber.text = self.data?.mobileNumber
                self.email.text = self.data?.email
            }
            
        }, failure:{
            
            (Error) in
            print("Somthing went wrong")
    })
    }
    
    func setFont()
    {
        name.font = MuliFontBook.Bold.of(size: 14)
        email.font = MuliFontBook.SemiBold.of(size: 14)
        phoneNumber.font = MuliFontBook.SemiBold.of(size: 14)
        helpLbl.font = MuliFontBook.SemiBold.of(size: 14)
        helpDescLbl.font = MuliFontBook.Regular.of(size: 12)
        
    }
}
