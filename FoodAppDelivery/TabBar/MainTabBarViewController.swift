//
//  MainTabBarViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
            tabBar.items?[0].title = "Ride".localized()
            tabBar.items?[1].title = "Orders".localized()
            tabBar.items?[2].title = "Account".localized()
            self.tabBar.tintColor = UIColor(hexString: "#EF6537")
        
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
