//
//  OrdersViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataModel = OrderDataModel()
    let fbShimmer = FBShimmer()

    var dataArray : [ListPastOrder]? {
        didSet
        {
            tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:
                {
                    self.stopLoading()
                })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        tableView.separatorColor = .clear
        showLoading()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataModel.requestToGetOrderDetailsData(success: {
            (JSON) in
            
            let status = JSON.error
            
            if status == "false"
            {
                self.dataArray = JSON.listPastOrders
            }
            else{
                print("Something went wrong")
            }
            
        }, failure: {
            (Error) in
            print("Something went wrong")
            
        })
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


extension OrdersViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        cell.restaurantNameLbl.text = dataArray?[indexPath.row].restaurantDetails?.restaurantName
        cell.restaurantAddressLbl.text = dataArray?[indexPath.row].restaurantDetails?.restaurantAddress
        cell.userNameLbl.text = dataArray?[indexPath.row].customerDetails?.userName
        cell.userAddressLbl.text = dataArray?[indexPath.row].customerDetails?.userAddress
        
        cell.paidViaLbl.setDifferentColor(firstString: dataArray?[indexPath.row].customerDetails?.paymentType ?? " ", secondString: dataArray?[indexPath.row].customerDetails?.totalAmount ?? "")
       
        cell.orderNumberLbl.text = dataArray?[indexPath.row].customerDetails?.orderRefferenceID
        
        cell.actionViewHeightConstant.constant = 0
        cell.statusView.isHidden = true
        
        cell.actionView.isHidden = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let StoaryBoard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let dvc = StoaryBoard.instantiateViewController(withIdentifier: "OrderDetailViewController")as! OrderDetailViewController
        dvc.orderID = self.dataArray?[indexPath.row].orderID
        dvc.isFrom = "PastOrder"
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension OrdersViewController
{
    func showLoading()
    {
        fbShimmer.loadanimatingView(frame: screenFrame, view: self.view)
    }
    
    func stopLoading()
    {
        fbShimmer.stopanimatingView()
    }
    
}
