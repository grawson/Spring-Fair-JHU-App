//
//  Modules.swift
//  Spring Fair
//
//  Created by Gavi Rawson on 12/21/15.
//  Copyright © 2015 Graws Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK: - UIColor extensions
//********************************************************
extension UIColor {
    
    /**
     Create an RGB color from hex value
     
     - parameter red:   red value
     - parameter green: green value
     - parameter blue:  blue value
     
     - returns: The RGB UIColor
     */
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /**
     Create an RGB color from hex value
     
     - parameter netHex: hex value
     
     - returns: The RGB UIColor
     */
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


//MARK: - UIView extensions
//********************************************************
extension UIView {
    /**
     Round corners of a view
     
     - parameter corners: The corners to round
     - parameter radius:  The rounding radius
     */
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}


//MARK: - JSON extensions
//********************************************************
extension JSON {
   
    /**
     Format a timestamp for printing in "h:mm a" format
     
     - parameter date: the unformatted time
     
     - returns: the formatted time
     */
    func formatTime(date: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        //formatter.timeZone = NSTimeZone(name: "UTC")
        let date = formatter.dateFromString(date)
        
        formatter.dateFormat = "h:mm a"
        formatter.AMSymbol = "am"
        formatter.PMSymbol = "pm"
        //formatter.timeZone = NSTimeZone(name: "UTC")
        return formatter.stringFromDate(date!)
    }
}


//MARK: - String extensions
//********************************************************
extension String {
    
    /***** MAY NOT WORK - test it ***/

    
     /**
     Convert date from database format to printable date
     
     - parameter date: database formatted date
     
     - returns: formatted date
     */
    func getDay(date: String)->String? {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.dateFromString(date) {  //create NSDate object
            //convert string into weekday
            formatter.dateFormat = "EEEE"
            let weekday: String = formatter.stringFromDate(date)
            return weekday
        }
        return nil
    }
}


//MARK: - UITableView extensions
//********************************************************
extension UITableView {
    
    /**
     Present an error label over a table view
     
     - parameter text:  Text for the error label
     - parameter color: Color of the error label text
     */
    func errorLabel(text: String, color: UIColor) {
        
        //Add footer view
        let errorView = UIView()
        self.tableFooterView = errorView //hide empty separator lines
        
        //create label and style
        let label = UILabel(frame: CGRectMake(0, 0, self.frame.width, 40))
        label.text = text
        label.textAlignment = NSTextAlignment.Center;
        label.font = (UIFont(name: "Open Sans Condensed", size: 20))
        label.textColor = color
        
        //center
        label.center.x = self.center.x
        label.center.y = self.center.y / 1.5
        
        errorView.addSubview(label)
    }
}

//MARK: - UIViewController extensions
//********************************************************
extension UIViewController {
    
    /**
     Present an alert view.
     
     - parameter title:   Title for the alert
     - parameter message: message for the alert
     */
    func alert(title: String, message: String) {
        let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
            
        //add action (OK)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        
        //present the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
}


//MARK: - UIButton extensions
//********************************************************
extension UIButton {
    
    /**
     Set the background color for a button
     
     - parameter color:    background color for the button
     - parameter forState: state of the button for which to set the background color
     */
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, forState: forState)
    }
}



