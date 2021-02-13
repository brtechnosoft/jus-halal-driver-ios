//
//  OrderDetailViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 20/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var orderStatusLbl: UILabel!
    @IBOutlet weak var orderTitleLbl: UILabel!
    @IBOutlet weak var orderTimeLbl: UILabel!
    @IBOutlet weak var orderNumberLbl: UILabel!
    
    @IBOutlet weak var restaurantLbl: UILabel!
    @IBOutlet weak var restaurantNameLbl: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var customerAddressLbl: UILabel!
    
    @IBOutlet weak var tableViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var paidViaLbl: UILabel!
    @IBOutlet weak var btnTripStatus: UIButton!
    var orderID : Int?
    let dataSource = RideViewDataModel()
    @IBOutlet weak var restaurantMapView: UIView!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantNavigateLbl: UILabel!
    
    @IBOutlet weak var userMapView: UIView!
    @IBOutlet weak var userNavigateLbl: UILabel!
    var dataArray: OrderDetails?
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var callLbl: UILabel!
    @IBOutlet weak var callViewRestaurantLbl: UILabel!
    @IBOutlet weak var callViewRestaurantPhoneNoLbl: UILabel!
    
    @IBOutlet weak var callViewTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var callViewCustomerLbl: UILabel!
    @IBOutlet weak var callViewCustomerPhoneNoLbl: UILabel!
    @IBOutlet weak var tripStatusHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var userViewWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var restaurantViewWidthConstant: NSLayoutConstraint!
    
    @IBOutlet weak var billDetailViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var billDetailsTableView: UITableView!
    @IBOutlet weak var topCallView: UIView!
    var isFrom: String? = ""
    var billDataarray : [Charges]?
    {
        didSet{
            billDetailsTableView.reloadData()
        }
    }

    var dishDataArray : [Dishes]?
    {
        didSet{
            dishesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dishesTableView.delegate = self
        dishesTableView.dataSource = self
        dishesTableView.separatorColor = .clear
        dishesTableView.isScrollEnabled = false
        
        billDetailsTableView.delegate = self
        billDetailsTableView.dataSource = self
        billDetailsTableView.separatorColor = .clear
        billDetailsTableView.isScrollEnabled = false

        orderStatusLbl.layer.cornerRadius = 3
        orderStatusLbl.layer.masksToBounds = true

        dishesTableView.register(UINib(nibName: "SingleItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleItemTableViewCell")
        
        billDetailsTableView.register(UINib(nibName: "BillDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "BillDetailTableViewCell")
        
        dataSource.delegate = self
        dataSource.requestToGetOrderDetails(orderID: orderID!)
        
        restaurantMapView.layer.cornerRadius = 3
        userMapView.layer.cornerRadius = 3
        
        orderTitleLbl.text = "ORDER STATUS"
        restaurantNavigateLbl.text = "NAVIGATE".localized()
        userNavigateLbl.text = "NAVIGATE".localized()
        
        callViewRestaurantLbl.text = "RESTAURANT".localized()
        callViewCustomerLbl.text = "CUSTOMER".localized()
        
        restaurantLbl.text = "RESTAURANT".localized()
        customerLbl.text = "CUSTOMER".localized()
        
        setFont()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.callViewTopConstraints.constant = -230
        self.callView.isHidden = true
        self.bgView.isHidden = true
        
        dishesTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        billDetailsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if let obj = object as? UITableView
        {
            if obj == dishesTableView
            {
                tableViewHeightConstant.constant = dishesTableView.contentSize.height
            }
            else
            {
                billDetailViewHeightConstant.constant = billDetailsTableView.contentSize.height + 40
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
   
        dishesTableView.removeObserver(self, forKeyPath: "contentSize")
        billDetailsTableView.removeObserver(self, forKeyPath: "contentSize")

        self.tabBarController?.tabBar.isHidden = false

        
    }
   
    @IBAction func restaurantNavigateAtn(_ sender: Any) {
        navigateToLocation()
    }
    
    @IBAction func userNavigateAtn(_ sender: Any) {
        navigateToLocation()
    }
    
    func navigateToLocation()
    {
        let lat = 13.06
        let lon = 80.23
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {

            UIApplication.shared.open(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving")! as URL , options: [:])

        }else {
             NSLog("Can't use comgooglemaps://");

               //  if GoogleMap App is not installed
                UIApplication.shared.open(NSURL(string:
                    "https://maps.google.com/?q=@\(Float(lat)),\(Float(lon))&directionsmode=driving")! as URL , options: [:])
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
    
    @IBAction func backAtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deliveryStatusAtn(_ sender: Any) {
        var urlType: String? = ""
        
        print("deliveryStatusAtn = ",self.dataArray)
        
        
        if self.dataArray?.orderStatus == "accepted"
        {
            urlType = "0"
        }
        else if self.dataArray?.orderStatus == "pickedup"
        {
            urlType = "1"
        }
        
        if urlType != ""
        {
        dataSource.requestToPickOrder(OrderID: orderID!, urlName: urlType!, success: {
            (JSON) in
            
            let status = JSON.error
            
            if status == "false"
            {
                self.dataSource.requestToGetOrderDetails(orderID: self.orderID!)
            }
            else{
                
                print("Something went wrong")
            }
            
        }, failure: {
            (Error) in
            print("Something went wrong")
        })
        }
        
    }

    @IBAction func callAtn(_ sender: Any) {
        
        self.callView.isHidden = false
        self.bgView.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.callViewTopConstraints.constant = 0
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                
        })
        
        
    }
    
    @IBAction func callViewCloseAtn(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations:
            {
                self.callViewTopConstraints.constant = -230
                self.view.layoutIfNeeded()
        },
                       completion:
            {
                (finished: Bool) in
                self.callView.isHidden = true
                self.bgView.isHidden = true

        })
        
    }
    
    @IBAction func callToRestaurantAtn(_ sender: Any) {
        
        let restaurantPhoneNumber = dataArray?.outletMobileNumber
        guard let number = restaurantPhoneNumber else
        {
            return
        }
        
        number.makeAColl()
        
    }
    
    @IBAction func callToCustomerAtn(_ sender: Any) {
        
        let customerPhoneNumber = dataArray?.userMobileNumber
        guard let number = customerPhoneNumber else
        {
            return
        }
        number.makeAColl()
    }

}





extension OrderDetailViewController : OrderDetailsDelegate
{
    func didReceiveOrderDetails(response: OrderDetails) {
        
        self.dataArray = response
        dishDataArray = dataArray?.dishes
        billDataarray = dataArray?.charges

        /*
        let a : Percentage = response.charges[0].percentage!
        let type = a
        
        switch type
        {
            case .integer(let value) :
                    print("Value = ",value)
            break
            case .string(let value):
                    print("Value = ",value)
            break
            default:
                
            break
        }
*/
        
        
      
        

        
        
        titleLbl.text = self.dataArray?.userName
        descLbl.text =  (self.dataArray?.netAmount)!
        orderStatusLbl.text = "  " + (self.dataArray?.orderStatus.uppercased())! + "  "
        
        orderTimeLbl.text = formatTime(time: self.dataArray?.orderStatusTime ?? "")
        
        orderNumberLbl.text = self.dataArray?.orderReferenceID
        restaurantNameLbl.text = self.dataArray?.outletName
        restaurantAddress.text = self.dataArray?.outletAddress
        restaurantAddress.numberOfLines = 0
        customerAddressLbl.numberOfLines = 0
        customerNameLbl.text = self.dataArray?.userName
        customerAddressLbl.text = self.dataArray?.userAddress
        paidViaLbl.text = "BILL DETAILS".localized()
        
        callViewRestaurantPhoneNoLbl.text = self.dataArray?.outletMobileNumber
        callViewCustomerPhoneNoLbl.text = self.dataArray?.userMobileNumber
        
        if self.dataArray?.orderStatus == "accepted"
        {
            btnTripStatus.setTitle("PickUp Order".localized(), for: .normal)
            
            restaurantMapView.isHidden = false
            userMapView.isHidden = true

            restaurantViewWidthConstant.constant = 60
            userViewWidthConstant.constant = 0
        }
        else if self.dataArray?.orderStatus == "pickedup"
        {
            btnTripStatus.setTitle("Deliver Order".localized(), for: .normal)
            
            restaurantMapView.isHidden = true
            userMapView.isHidden = false
            restaurantViewWidthConstant.constant = 0
            userViewWidthConstant.constant = 60
        }
        
        else if self.dataArray?.orderStatus == "delivered"{
            self.btnTripStatus.setTitle("Delivered".localized(), for: .normal)
            restaurantMapView.isHidden = true
            userMapView.isHidden = true
            
            restaurantViewWidthConstant.constant = 00
            userViewWidthConstant.constant = 0
        }
        
        if isFrom == "PastOrder"
        {
            btnTripStatus.isHidden = true
            restaurantMapView.isHidden = true
            userMapView.isHidden = true
            topCallView.isHidden = true
            tripStatusHeightConstant.constant = 0
            
            restaurantViewWidthConstant.constant = 0
            userViewWidthConstant.constant = 0
        }
    }
    
    func didFailOrderDetails(error: Error) {
        print("Error = ",error.localizedDescription)
    }
    
}

extension OrderDetailViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == self.dishesTableView
        {
            return dishDataArray?.count ?? 0
        }
        else{
            return billDataarray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableviewCell  = UITableViewCell()
     
        if tableView == dishesTableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleItemTableViewCell", for: indexPath) as! SingleItemTableViewCell
            cell.dishNameLbl.text = dishDataArray?[indexPath.row].dishplayDish//.displayDish
            cell.dishPriceLbl.text = dishDataArray?[indexPath.row].displayPrice//.displayPrice
        
            if dishDataArray?[indexPath.row].isVeg == "0"
            {
                cell.imgType.image = UIImage(named: "Veg")
            }
            else{
                cell.imgType.image = UIImage(named: "NonVeg")
            }
        
            cell.addonsHeightConstant.constant = 0
            cell.addonsView.isHidden = true
            cell.selectionStyle = .none
            
            tableviewCell = cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillDetailTableViewCell", for: indexPath) as! BillDetailTableViewCell
            cell.displayName.text = billDataarray?[indexPath.row].displayKey
            cell.displayAmount.text = billDataarray?[indexPath.row].displayValue
           
            tableviewCell = cell
        }
        
        return tableviewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
}

extension OrderDetailViewController
{
    func setFont()
    {
        titleLbl.font = MuliFontBook.SemiBold.of(size: 14)
        descLbl.font = MuliFontBook.Regular.of(size: 14)
        orderTitleLbl.font = MuliFontBook.Bold.of(size: 14)
        orderStatusLbl.font = MuliFontBook.Regular.of(size: 12)
        orderTimeLbl.font = MuliFontBook.SemiBold.of(size: 12)
        orderNumberLbl.font = MuliFontBook.SemiBold.of(size: 12)
        
        restaurantLbl.font = MuliFontBook.Bold.of(size: 14)
        restaurantNameLbl.font = MuliFontBook.SemiBold.of(size: 14)
        restaurantAddress.font = MuliFontBook.SemiBold.of(size: 14)
        
        customerLbl.font = MuliFontBook.Bold.of(size: 14)
        customerNameLbl.font = MuliFontBook.SemiBold.of(size: 14)
        customerAddressLbl.font = MuliFontBook.SemiBold.of(size: 14)
        
        paidViaLbl.font = MuliFontBook.Bold.of(size: 14)
    }
}
