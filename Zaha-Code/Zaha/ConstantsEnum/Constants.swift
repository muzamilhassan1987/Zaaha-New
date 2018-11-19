//
//  Constants.swift
//

import UIKit
import CoreLocation
enum Constants {
    static let minimumLengthName = 3
    static let maximumLengthName = 30
    static let maximumLengthNumber = 20
    static let minimumLengthNumber = 8
    static let maximumLengthText = 30
    static let minimumLengthPwd = 6
    static let maximumLengthPwd = 20
    static let maximumLengthTextView = 500
    static let networkSessionToken  = ""
    static let selectedColor = UIColor(red: 198/255, green: 0/255, blue: 37/255, alpha: 1)
    
    static let APP_DELEGATE  = UIApplication.shared.delegate as! AppDelegate
    static let UIWINDOW      = UIApplication.shared.delegate!.window!
    
}

enum HeaderHeight :CGFloat {
    case mainHeaderHeight = 260.0
    case subTitleHeaderHeight = 50.0
}

struct Color
{
    static let appDarkPink = UIColor(red:0.863, green:0.714, blue:0.745, alpha:1.0)
    static let appLightPink = UIColor(red:0.926, green:0.883, blue:0.890, alpha:1.0)
    static let appDarkGray = UIColor(red:0.506, green:0.506, blue:0.506, alpha:1.0)
    static let appLightGray = UIColor(red:0.573, green:0.573, blue:0.573, alpha:1.0)
    static let appBlueText = UIColor(red:0.482, green:0.600, blue:0.776, alpha:1.0)
    static let appSeperator = UIColor(red:0.933, green:0.933, blue:0.933, alpha:1.0)
    static let appSeperatorColor = UIColor(red:0.722, green:0.722, blue:0.722, alpha:1.0)
    
    enum BookStatus {
        static let view         = UIColor.init(hexString: "#C89F68")
        static let confirmed    = UIColor.init(hexString: "#4F622B")
        static let pending      = UIColor.init(hexString: "#CCA02B")
        static let rejected     = UIColor.init(hexString: "#BC3C26")
    }
    
}

enum FP {
    static var emailUser = ""
    static var loginGuest  = false
}


enum Culture{
    static var data : [CultureData]? = nil
    
}
enum CurrentUser{
    //var currentLocation(location, locationString) = (CLLocationCoordinate2D(), "")
    //var tupleVar = (CLLocationCoordinate2D, String, String)
    static var currentLocation : CLLocation?
    static var data : UserData? = nil
    static var token : String = ""
    static var userType : UserType = .registered
    static var selectedAddressID : Int = 0
    static var deviceToken : String = "123456"
    static var instantOrder : String = "We can process your laundry in immediately in the same day, just choose Instant Order between 09:00:09 am to  02:00:09 pm and we will deliver it before 09:00:17 pm the last delivery time"
    
}

enum Login {
    static let isLoggedIn : String = "isLoggedIn"
    static let userData : String = "userData"
    static let token : String = "token"
}


enum CartData {
    static var cartDict : [Int : (quantity : Int, amount: Float , item : String , section :Int)] = [:]
    static var totalAmount : Float  = 0
    static var totalQuantity : Int = 0
    static var params : [String : AnyObject] = [:]
    static var orderDetail : [[String : AnyObject]] = [[:]]
    static var instanceSurCharge : Float = 0.0
    static var amtFinal : Float = 0.0
    static var SD : SheduleData =  SheduleData()
}

enum GoogleMap{
    static let key : String = "AIzaSyBbm5LaMZF6g7RcATzFsVyz9BuaPrrefxM" // "AIzaSyD7sU52onvkEkZd0NwlFXGbOQ-C791LVh4"
    
}

enum ServiceCodes {
    static let successCode : Int = 200
}

enum UserDefaultKey {
    static let isConfigurationSaved = "isConfigurationSaved"
    static let selectedAddress = "selectedAddress"
    static let deviceToken = "deviceToken"
    static let cardData = "cardData"
}

enum UserType{
    case registered
    case guest
    
}


enum OrderData{
    static var orderNotification : (type: String, id :Int) = ("", 0)
}

struct SheduleData {
    var isInstance  = false
    var selectedTimes : (String? , String?) = (nil, nil)
    var selectedDates : (Date? , Date?) = (nil, nil)
    var selectedAddress : (String? , String?) = (nil, nil)
}


enum BookingDetailEnum : Int {
    case none
    case upcomingExperience
    case nearMe
    case booking
    case stories
    case myExperience
    case pastExperience
}


enum CodeType {
    case signup , forgetPwd
}

enum Type {
    static var data : [TypeData]? = nil
}

enum BookingDetailCellEnum: Int
{
    //case imageSlidShowCell
    //case buttonsCell
    case info
    case description
    
}

enum cellIdentifiers : String {
    case amenities = "AmenitiesTableCell"
    case description = "DescriptionCell"
    case buttons = "ButtonsCell"
    case viewAll = "ViewAllCell"
    case photoVideoCell = "PhotoCollectionTableCell"
}


enum BookingStatus : Int {
    case Available
    case Pending
    case Cancel
    case Rejected
    case Completed  
}
