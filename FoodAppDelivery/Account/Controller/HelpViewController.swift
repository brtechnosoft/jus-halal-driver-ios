//
//  HelpViewController.swift
//  FoodAppUser
//
//  Created by Pyramidions on 26/12/18.
//  Copyright © 2018 Pyramidions. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var webURL: String = ""
    var dataSource = AccountDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        dataSource.requestToGetStatic(success: {
            (HelpDataModel) in
            
            if HelpDataModel.error == "false"
            {
                let url = URL(string: HelpDataModel.faqPages!)
                self.webView.load(URLRequest(url: url!))
            }
            
        }, failure: {
            (Error) in
            print("Error")
        })
        
        
        helpLbl.text = "Help".localized()
        helpLbl.font = MuliFontBook.SemiBold.of(size: 16)
        
    }
    
    @IBAction func backAtn(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.tabBarController?.tabBar.isHidden = true
//
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = false
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
