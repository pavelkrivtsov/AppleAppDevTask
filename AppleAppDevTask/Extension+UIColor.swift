//
//  Extension+UIColor.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 12.05.2023.
//

import UIKit

public extension UIColor {
    
    //    convenience init(hex: Int, alpha: CGFloat = 1.0) {
    //        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    //        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
    //        let blue = CGFloat((hex & 0xFF)) / 255.0
    //
    //        self.init(red: red, green: green, blue: blue, alpha: alpha)
    //    }
    
    convenience init(hex string: String, alpha: CGFloat = 1.0) {
        var hex = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        if hex.count < 3 {
            hex = "\(hex)\(hex)\(hex)"
        }
        
        if hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil {
            if hex.count == 3 {
                
                let startIndex = hex.index(hex.startIndex, offsetBy: 1)
                let endIndex = hex.index(hex.startIndex, offsetBy: 2)
                
                let redHex = String(hex[..<startIndex])
                let greenHex = String(hex[startIndex..<endIndex])
                let blueHex = String(hex[endIndex...])
                
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            
            let startIndex = hex.index(hex.startIndex, offsetBy: 2)
            let endIndex = hex.index(hex.startIndex, offsetBy: 4)
            let redHex = String(hex[..<startIndex])
            let greenHex = String(hex[startIndex..<endIndex])
            let blueHex = String(hex[endIndex...])
            
            var redValue: UInt64 = 0
            var greenValue: UInt64 = 0
            var blueValue: UInt64 = 0
            
            Scanner(string: redHex).scanHexInt64(&redValue)
            Scanner(string: greenHex).scanHexInt64(&greenValue)
            Scanner(string: blueHex).scanHexInt64(&blueValue)
            
            self.init(red: CGFloat(redValue) / 255.0,
                      green: CGFloat(greenValue) / 255.0,
                      blue: CGFloat(blueValue) / 255.0,
                      alpha: CGFloat(alpha))
        }
        else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
}



//{
//    "company": {
//        "companyId": "99df1b98-2861-4ed2-93c4-f8e3c5c18ce7"
//    },
//    "customerMarkParameters": {
//        "loyaltyLevel": {
//            "number": 7,
//            "name": "платиновый",
//            "requiredSum": 10823,
//            "markToCash": 93,
//            "cashToMark": 68
//        },
//        "mark": 496
//    },
//    "mobileAppDashboard": {
//        "companyName": "Венская кофейня",
//        "logo": "http://bonusmoney.info/image/mail/bm.png",
//        "backgroundColor": "#EFEFEF",
//        "mainColor": "#2688EB",
//        "cardBackgroundColor": "#FFFFFF",
//        "textColor": "#949494",
//        "highlightTextColor": "#1A1A1A",
//        "accentColor": "#FF3044"
//    }
//}

//"mobileAppDashboard": {
//    "companyName": "У тебя может получиться!",
//    "logo": "http://bonusmoney.info/image/mail/bm.png",
//    "backgroundColor": "#4E63A6",
//    "mainColor": "#66FC73",
//    "cardBackgroundColor": "#8F9341",
//    "textColor": "#237186",
//    "highlightTextColor": "#0E529B",
//    "accentColor": "#4014F8"
//}
