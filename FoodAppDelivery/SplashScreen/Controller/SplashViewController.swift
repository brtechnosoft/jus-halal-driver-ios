//
//  SplashViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 11/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit
import CoreLocation


class SplashViewController: UIViewController,CLLocationManagerDelegate
{
    
    let manager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        manager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:
            {
                
                if UserDefaults.standard.isLoggedIn()
                {
                    let StoaryBoard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
                    let dvc = StoaryBoard.instantiateViewController(withIdentifier: "MainTabBarViewController")as! MainTabBarViewController

                    self.present(dvc, animated: true, completion: nil)
                }
                else
                {
            
                    let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    let dvc = StoaryBoard.instantiateViewController(withIdentifier: "LoginCreateViewController")as! LoginViewController
                    dvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(dvc, animated: true, completion: nil)
                }
        })
        
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
