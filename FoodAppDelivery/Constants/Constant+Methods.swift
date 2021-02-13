//
//  Constant+Methods.swift
//  FoodAppUser
//
//  Created by Pyramidions on 13/10/18.
//  Copyright © 2018 Pyramidions. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


func configureLinearProgressBar(linearBar :LinearProgressBar)
{
    linearBar.backgroundColor = UIColor.clear
    linearBar.progressBarColor = UIColor(hexString: "#FAD05B")
    linearBar.backgroundProgressBarColor = UIColor.clear
    linearBar.heightForLinearBar = 3
    linearBar.linearBarWidth = 150
}

func startLocalNotification(otp :String)
{
    let content = UNMutableNotificationContent()
    content.title = "OTP".localized()
    content.body = otp
    content.badge = 0
    
    //Setting time for notification trigger
    let date = Date(timeIntervalSinceNow: 1)
    let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
    //Adding Request
    let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

func presentRight() -> CATransition
{
    let transition = CATransition()
    transition.duration = 0.6
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    return transition
}

func presentLeft() -> CATransition
{
    let transition = CATransition()
    transition.duration = 0.6
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromLeft
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    return transition
}

func getDeviceID() ->String
{
    var deviceID : String?
    if UIDevice.current.identifierForVendor!.uuidString as? String != nil
    {
        deviceID = UIDevice.current.identifierForVendor!.uuidString
    }
    else{
        deviceID = ""
    }
    return deviceID!
}

func slashedPrice(text: String) -> NSAttributedString{
    
    let attributedText = NSMutableAttributedString(string: text)
    attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
     value: 1, range: NSMakeRange(0, attributedText.length))
    
    return attributedText
}

func timeString(time:TimeInterval) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%2i:%02i",minutes, seconds)
}

func formatTime(time: String) -> String
{
    let inFormatter = DateFormatter()
    inFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    inFormatter.dateFormat = "hh:mm:ss a"
    
    let outFormatter = DateFormatter()
    outFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    outFormatter.dateFormat = "hh:mm a "
    
    let date = inFormatter.date(from: time)!
    return outFormatter.string(from: date)
}

