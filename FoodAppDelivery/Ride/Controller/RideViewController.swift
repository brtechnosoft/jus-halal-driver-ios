//
//  RideViewController.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit
import CoreLocation
import SocketIO

class RideViewController: UIViewController {
 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var todayDeliveryLbl: UILabel!
    @IBOutlet weak var todayTotalOrderLbl: UILabel!
    @IBOutlet weak var todayTotalAmountLbl: UILabel!
  
    @IBOutlet weak var yesterdayDeliveryLbl: UILabel!
    @IBOutlet weak var yesterdayTotalAmountLbl: UILabel!
    @IBOutlet weak var yesterdayTotalOrderLbl: UILabel!
    
    @IBOutlet weak var weeklyDeliveryLbl: UILabel!
    @IBOutlet weak var weeklytotalAmountLbl: UILabel!
    @IBOutlet weak var weeklyTotalOrderLbl: UILabel!
    
    @IBOutlet weak var startTripLbl: UILabel!
    @IBOutlet weak var stopTripLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var stopView: UIView!
    
    @IBOutlet weak var rideView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var dataTableView: UITableView!
    
    let locationManager = LocationManager()
    let dataSource = RideViewDataModel()
    var isGetAssignOrder: Bool? = false
    
    var socket : SocketIOClient!
    var manager : SocketManager!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusDescLbl: UILabel!
    @IBOutlet weak var userState: UISwitch!
    @IBOutlet weak var topView: UIView!
    
    var dataArray :Orders?  {
        didSet
        {
            dataTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name.text = UserDefaults.standard.getUserName()
        btnStart.setTitle("ONLINE".localized(), for: .normal)
        btnStop.setTitle("OFFLINE".localized(), for: .normal)

        self.startTripLbl.text = "Start Trip".localized()
        self.stopTripLbl.text = "Stop Trip".localized()
        self.descLbl.text = "Start trip to get delivery orders".localized()
        
        locationManager.delegate = self

        dataTableView.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        dataTableView.isScrollEnabled = false
      
        setFont()
        dataView.isHidden = true
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.separatorColor = .clear
        print("USERID", UserDefaults.standard.getUserID())

        userState.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        userState.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        userState.onTintColor =  .white
        userState.tintColor = .white

        locationManager.startUpdatingLocation()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isGetAssignOrder = false
        dataSource.requestToUpdateDeviceToken()
        getHomeDetails()

    }
    
    @objc func switchValueDidChange(_ sender: UISwitch) {
      
        if userState.isOn == true {
            print("On")
            updataDeliveryAvailableStatus(status: 1)
        }
        else {
            print("Off")
            updataDeliveryAvailableStatus(status: 0)
          
            locationManager.stopUpdatingLocation()
            if socket != nil
            {
                socket.disconnect()
            }
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

    @IBAction func startRideAtn(_ sender: Any) {
        
        updataDeliveryAvailableStatus(status: 0)
    }
    
    @IBAction func stopRideAtn(_ sender: Any) {
        
        locationManager.stopUpdatingLocation()
        updataDeliveryAvailableStatus(status: 1)
      
        if socket != nil
        {
            socket.disconnect()
        }
    }
    
    func getHomeDetails()
    {
        dataSource.requestHomeDetailsData(success: {
            (RideDataModel) in
            
            guard let status = RideDataModel.error else
            {
                return
            }
            if status == "false"
            {
                guard let staffAvailableStatus = RideDataModel.deliveryDetail?.tripStatus else
                {
                    return
                }
                
                UserDefaults.standard.setStaffAvailableStatus(value: staffAvailableStatus)

                self.todayDeliveryLbl.text = RideDataModel.deliveryDetail?.todayDisplayName
                self.yesterdayDeliveryLbl.text = RideDataModel.deliveryDetail?.yesterdayDisplayName
                self.weeklyDeliveryLbl.text = RideDataModel.deliveryDetail?.weekDisplayName
                
                self.todayTotalOrderLbl.text = String(describing:(RideDataModel.deliveryDetail?.todayOrders)!) + " " + "Orders".localized()
                self.yesterdayTotalOrderLbl.text = String(describing:(RideDataModel.deliveryDetail?.yesterdayOrders)!) + " " + "Orders".localized()
                self.weeklyTotalOrderLbl.text = String(describing:(RideDataModel.deliveryDetail?.weekOrders)!) + " " + "Orders".localized()
               
                self.todayTotalAmountLbl.text = RideDataModel.deliveryDetail?.todayCost
                self.yesterdayTotalAmountLbl.text = RideDataModel.deliveryDetail?.yesterdayCost
                self.weeklytotalAmountLbl.text = RideDataModel.deliveryDetail?.weekCost
                self.setAvialableStatus()

            }
            else{
                
            }
            
        },failure:{
            
            (Error) in
            
        } )
    }
    
    func updataDeliveryAvailableStatus(status: Int)
    {
        
        dataSource.requestToUpdateStatus(status: status, success: {
            
            (StatusModel) in
            
            guard let resStatus = StatusModel.error else
            {
                return
            }
            
            if resStatus == "false"
            {
                UserDefaults.standard.setStaffAvailableStatus(value: status)
                self.setAvialableStatus()
            }
            
        }, failure:
            {
            (Error) in
                
        })
        
    }
    
}


extension RideViewController
{
    func setFont()
    {
        name.font = MuliFontBook.SemiBold.of(size: 16)
        todayDeliveryLbl.font = MuliFontBook.Regular.of(size: 10)
        todayTotalAmountLbl.font = MuliFontBook.SemiBold.of(size: 16)
        todayTotalOrderLbl.font = MuliFontBook.SemiBold.of(size: 12)
        
        weeklyDeliveryLbl.font = MuliFontBook.Regular.of(size: 10)
        weeklytotalAmountLbl.font = MuliFontBook.SemiBold.of(size: 16)
        weeklyTotalOrderLbl.font = MuliFontBook.SemiBold.of(size: 12)
        
        yesterdayDeliveryLbl.font = MuliFontBook.Regular.of(size: 10)
        yesterdayTotalAmountLbl.font = MuliFontBook.SemiBold.of(size: 16)
        yesterdayTotalOrderLbl.font = MuliFontBook.SemiBold.of(size: 12)

        startTripLbl.font = MuliFontBook.SemiBold.of(size: 16)
        stopTripLbl.font = MuliFontBook.SemiBold.of(size: 16)
        
        descLbl.font = MuliFontBook.SemiBold.of(size: 12)
        
        btnStop.titleLabel?.font = MuliFontBook.SemiBold.of(size: 12)
        btnStart.titleLabel?.font = MuliFontBook.SemiBold.of(size: 12)
        
        statusLbl.font = MuliFontBook.SemiBold.of(size: 16)
        statusDescLbl.font = MuliFontBook.SemiBold.of(size: 12)

    }
    
    func setAvialableStatus()
    {
        self.userState.onTintColor = .white
        self.userState.tintColor = .white
        self.userState.backgroundColor = .white
        self.userState.layer.cornerRadius = 16
        
        if UserDefaults.standard.getStaffAvailableStatus() == 0
        {
            self.userState.isOn = false
            self.statusLbl.text = "You are offline now".localized()
            self.statusDescLbl.text = "Go Online to start Earning".localized()
            let navyBlue = UIColor(named:"NavyBlue")
            self.topView.backgroundColor = navyBlue
            self.userState.thumbTintColor = navyBlue
        }
        else
        {
            self.userState.isOn = true
            self.statusLbl.text = "You are Online now".localized()
            self.statusDescLbl.text = "Go Offline to stop".localized()
            let appGreenClr = UIColor(named:"appGreenColor")
            self.topView.backgroundColor = appGreenClr
            self.userState.thumbTintColor = appGreenClr
        }
        
        dataSource.requestToGetOrder(isAssignOrder:false , success: {
            (JSON) in
              
            if JSON != nil
            {
                let status = JSON.error
                if status == "false"
                {
                    self.dataView.isHidden = false
                    // self.rideView.isHidden = true
                    self.dataArray = JSON.orders
                }
                else
                {
                    if UserDefaults.standard.getStaffAvailableStatus() == 1
                    {
                        self.rideView.isHidden = true
                        self.getAssignOrders()
                    }
                    else
                    {
                        self.dataView.isHidden = true
                        self.rideView.isHidden = false
                    }
                }
            }
        }
        , failure:
            {
                (Error) in
                print("Error")
            })
    }
    
    func getAssignOrders()
    {
        dataSource.requestToGetOrder(isAssignOrder: true, success: {
            (GetOrder) in
           
            let status = GetOrder.error
            if status == "false"
            {
                self.isGetAssignOrder = true
                self.dataView.isHidden = false
                self.dataArray = GetOrder.orders
            }
            else{
                self.dataView.isHidden = true
            }
            
        }, failure: {
            (Error) in
            print("Error")
        })
    }
    
    func orderDetailPage()
    {
        let StoaryBoard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let dvc = StoaryBoard.instantiateViewController(withIdentifier: "OrderDetailViewController")as! OrderDetailViewController
        dvc.orderID = self.dataArray?.orderID
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func connectToSocket(latitude: Double, longitude: Double)
    {
        manager = SocketManager(socketURL: URL(string: "http://139.59.70.80:8002/")!, config: [.log(false), .compress, .forcePolling(true)])
        socket = manager.defaultSocket

//      manager.config = SocketIOClientConfiguration(
//                            arrayLiteral: .compress, .connectParams(["latitude": "12.23" , "longitude": "15.23", "staffId": UserDefaults.standard.getUserID]))

        if(socket != nil)
        {
            socket.on(clientEvent: .connect)
            {
                data, ack in
                print("socket connected")
                let dict = ["latitude": latitude, "longitude": longitude, "staffId": UserDefaults.standard.getUserID() ] as [String : Any]
                self.socket.emit("updateLocation", dict)
            }
        }
        socket.connect()
    }
}


extension RideViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 //dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        
        cell.restaurantNameLbl.text = dataArray?.outletName
        cell.restaurantAddressLbl.text = dataArray?.outletAddress
        cell.userNameLbl.text = dataArray?.userName
        cell.userAddressLbl.text = dataArray?.usersAddress
        cell.orderNumberLbl.text = dataArray?.orderReferenceID
        cell.delegate = self
        let paidVia = dataArray?.paidVia
        let amt = dataArray?.netAmount
        cell.paidViaLbl.setDifferentColor(firstString:paidVia ?? ""  , secondString:amt ?? "" )
        cell.statusView.isHidden = true
    
        if dataArray?.orderStatus == "assigned" || isGetAssignOrder!
        {
            cell.actionViewHeightConstant.constant = 40
            cell.actionView.isHidden = false
        }
        else{
            cell.actionViewHeightConstant.constant = 0
            cell.actionView.isHidden = true
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if !isGetAssignOrder!
        {
            orderDetailPage()
        }
    }
    
}

extension RideViewController : OrderStatusDelegate
{
    func acceptOrder() {
        
        dataSource.requestToAcceptOrder(isAccept:true ,OrderID: (dataArray?.orderID)! , success: {
            (JSON) in
            
            if JSON.error == "false"
            {
                self.orderDetailPage()
                
            }else{
                print(JSON.errorMessage ?? "")
            }
            
        }, failure: {
            (Error) in
            
        })
       
    }
    
    func rejectOrder() {
        
        dataSource.requestToAcceptOrder(isAccept: false, OrderID: ((dataArray?.orderID)!), success: {
            
            (Json) in
        
            if Json.error == "false"
            {
                self.dataArray = nil
                self.dataTableView.isHidden = true
            }
            else{
                print("msg",Json.errorMessage!)
            }
            
        }, failure: {
            (Error) in
            
        })
    }
}


extension RideViewController : LocationServiceDelegate{
   
    func tracingLocation(currentLocation: CLLocation)
    {
        self.connectToSocket(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        
    }
    
}
