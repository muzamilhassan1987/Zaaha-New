//
//  LeftMenuController.swift
//  VIE
//
//  Created by aurangzaibkhan on 6/26/18.
//  Copyright © 2018 aurangzaibkhan. All rights reserved.
//

import UIKit
import LGSideMenuController
//import FCAlertView
import SwiftMessages
//import RealmSwift
//import SKActivityIndicatorView
import Alamofire

enum Menu: String
{
    case home = "Home"
    case stories = "Stories"
    case upcomingExp = "Upcoming Experiences"
    case nearMe = "Near Me"
    case pastExp = "Past Experiences"
    case myExp = "My Experiences"
    case inbox = "Inbox"
    case setting = "Settings"
    case about = "About"
    case booking = "Bookings"
}

extension Menu
{
    
    func getVc() -> BaseViewController
    {
        switch self
        {
        case .home:
            
            let controller = HomeVC.loadVC()
            controller.detailType = .none
            return controller
            
        case .stories:
            let controller = HomeVC.loadVC()
            controller.detailType = .stories
            return controller
            
        case .upcomingExp:
            let controller = HomeVC.loadVC()
            controller.detailType = .upcomingExperience
            return controller
        case .nearMe:
            let controller = HomeVC.loadVC()
            controller.detailType = .nearMe
            
            return controller
            
        case .pastExp:
            let controller = HomeVC.loadVC()
            controller.detailType = .pastExperience
            return controller
            
        case .myExp:
            let controller = HomeVC.loadVC()
            controller.detailType = .myExperience
            return controller
            
//        case .featuredAds:
//
////            let vc = AdsListingController.loadVC()
////            vc.navTitle = "Featured Ads"
////            return vc
//
//            let  parameters = [
//                "IsFeatured" : 1,
//                ] as [String : AnyObject]
//
//            let vc = HomeVC.loadVC()
//            vc.navTitle = "Featured Ads"
//            vc.parameters = parameters
//            return vc
//
//        case .favorites:
//
//            let  parameters = [
//                "isfavourite" : 1,
//                ] as [String : AnyObject]
//
//            let vc = HomeVC.loadVC()
//            vc.navTitle = "Favorites"
//            vc.parameters = parameters
//            return vc
//
//        case .myAds:
//
////            let vc = MyAdsListingController.loadVC()
////            //vc.navTitle = "My Ads"
////            return vc
//
//            let  parameters = [
//                "isMyAd" : 1,
//                ] as [String : AnyObject]
//
//            let vc = AdsListingController.loadVC()
//            vc.navTitle = "My Ads"
//            vc.parameters = parameters
//            return vc
//
//        case .exhibitions:
//            return ExhibitionController.loadVC()
//
//        case .notifications:
//           return NotificationController.loadVC()
//
//
            
        case .inbox:
            return InboxListViewController.loadVC()
            
        case .booking:
            return BookingListController.loadVC()
        case .setting:

            return SettingController.loadVC()
//
//        case .contactUs:
//            return ContactController.loadVC()
            
        case .about:
            return AboutController.loadVC()

        default :
            return BaseViewController()
        }
    }
    
    
    
}

class LeftMenuController: BaseViewController
{
    @IBOutlet weak var tblSideMenu: UITableView!
    
    @IBOutlet weak var imgProfile: BaseUIImageView!
    @IBOutlet weak var btnProfile: BaseUIButton!
    @IBOutlet weak var lblName: BaseUILabel!
    private let kTableHeaderHeight: CGFloat = DesignUtility.getValueFromRatio(80)
    
    var lastSelectedCell:SideMenuTableViewCell?
    //let manager = LogoutManager()
//    let realm = try! Realm()
    var manager = CultureManager()

    var menuArray = [
        ["icon":"sidebar_homeIcon", "type":Menu.home.rawValue, "selectedIcon":"Home_Selected"],
        ["icon":"sidebar_storiesIcon", "type":Menu.stories.rawValue, "selectedIcon":"Stories_Selected"],
        ["icon":"sidebar_upcomingExpIcon", "type":Menu.upcomingExp.rawValue, "selectedIcon":"Upcoming_Selected"],
        ["icon":"sidebar_nearbyIcon", "type":Menu.nearMe.rawValue, "selectedIcon":"NearMe_Selected"],
        ["icon":"sidebar_pastExpIcon", "type":Menu.pastExp.rawValue, "selectedIcon":"Past_Selected"],
        ["icon":"sidebar_myExpIcon", "type":Menu.myExp.rawValue, "selectedIcon":"MyExp_Selected"],
        ["icon":"sidebar_inboxIcon", "type":Menu.inbox.rawValue, "selectedIcon":"Inbox_Selected"],
        ["icon":"sidebar_settingsIcon", "type":Menu.setting.rawValue, "selectedIcon":"Settings_Selected"],
        ["icon":"sidebar_aboutIcon", "type":Menu.about.rawValue, "selectedIcon":"About_Selected"],
        ["icon":"sidebar_booking", "type":Menu.booking.rawValue, "selectedIcon":"Booking_Selected"]
    ]
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let url = CurrentUser.data?.imageUrl {
            print(url)
            imgProfile.setImageFromUrl(urlStr: url)
        }
        lblName.text = CurrentUser.data!.firstName!  + " " + CurrentUser.data!.lastName!
        getHomeList()
        //NSNotification.Name(rawValue: kLocationDidChangeNotification)
        self.view.backgroundColor = UIColor.white
       // setHeader()
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblSideMenu.reloadData()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
    }
    
    func setHeader()
    {
        tblSideMenu.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0 )
        tblSideMenu.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
    }
    
    
    func setRootViewController(_ vc: BaseNavigationController)
    {
        sideMenuController?.rootViewController = vc
        print(vc)
        //Singleton.sharedInstance.sideMenuVC = vc
        sideMenuController?.hideLeftViewAnimated()
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        sideMenuController?.hideLeftViewAnimated()
    }
    
    @IBAction func showProfile(_ sender: UIButton) {
        
        let controller = ViewProfileController.loadVC()
        setRootViewController(BaseNavigationController(rootViewController: controller))
        
    }
    
    
    func changeControllers(_ menu: Menu)
    {
//        if menu == .logOut
//        {
//            customAlert(title: NSLocalizedString("Logout", comment: ""), subTitle: NSLocalizedString("Are you sure you want to logout?", comment: ""), image: #imageLiteral(resourceName: "logo"))
//        }
//        else
//        {
//            setRootViewController(UINavigationController(rootViewController: menu.getVc()))
//        }
        print(menu.getVc())
        
        setRootViewController(BaseNavigationController(rootViewController: menu.getVc()))
    }
    
    func logOutService(){
        
//        self.view.endEditing(true)
//        if !Connectivity.isConnectedToInternet {
//            self.view.makeToast(AppString.internetUnreachable, duration: 1.5, position: .center)
//            return
//        }
//        
//        let headers: [String:String] = ["Authorization": "Bearer \(CurrentUser.token)"]
//        
//        let parameters = [
//            "deviceID" :CurrentUser.deviceToken,
//            "deviceType" : 2
//            ] as! [String:Any]
//        
//        print(headers)
//        print(parameters)
//        
//         SKActivityIndicator.show("Loading...", userInteractionStatus: false)
//        AFWrapper.requestPOSTURL("http://vie.ingicweb.com/API/api/User/LogOut", params: parameters, headers: headers, success: { (data) in
//            SKActivityIndicator.dismiss()
//            
//            try! self.realm.write{
//                self.realm.delete(CurrentUser.data!)
//            }
//            CurrentUser.data = nil
//            self.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
//            
//        }) { (Error) in
//            
//        }
        
   /*     let requestParam = self.manager.params(parameters: parameters as! [String : AnyObject])
        
        SKActivityIndicator.show("Loading...", userInteractionStatus: false)
        self.manager.api(requestParam, completion: {
            SKActivityIndicator.dismiss()
            
            if self.manager.isSuccess{
                
                try! self.realm.write{
                    self.realm.delete(CurrentUser.data!)
                }
                CurrentUser.data = nil
                //--FM  Constants.APP_DELEGATE.moveToSignIn()
                self.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
            }
            else{
                
            }
        }) */
        
    } // end logOutService
    
    func showAboutPopUp() {
        
        let controller = AboutController.loadVC()
        controller.type = AboutType.privacy
        controller.view.backgroundColor = UIColor.clear
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        sideMenuController?.present(controller, animated: true) {
            
        }
        //Constants.UIWINDOW?.addSubview(controller.view)
        
    }
    
} // end class LeftMenuController

extension LeftMenuController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return SideMenuTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //tableView.deselectRow(at: indexPath, animated: true)
        //tableView.selectRow(at: index, animated: <#T##Bool#>, scrollPosition: <#T##UITableView.ScrollPosition#>)

        let cell:SideMenuTableViewCell = tableView.cellForRow(at: indexPath) as! SideMenuTableViewCell
       
        cell.imgSideMenuIcon.image = UIImage(named:menuArray[indexPath.row]["icon"]!)
        if let sel = lastSelectedCell {
            if (cell != sel) {
                cell.lblTitle.textColor = UIColor.init(hexString: "#C89F68")
                lastSelectedCell!.lblTitle.textColor = UIColor.init(hexString: "#554C5B")
                lastSelectedCell = cell
            }
        }
        
        let cellType = (self.menuArray[indexPath.row] as NSDictionary)["type"] as! String
        
        if let menu = Menu(rawValue: cellType)
        {
            if (menu == Menu.about) {
             
                self.showAboutPopUp()
                return
            }
//            if (menu == Menu.nearMe) {
//
////                self.showAboutPopUp()
//                return
//            }
//            if (menu == Menu.inbox) {
//
//                //                self.showAboutPopUp()
//                return
//            }
            self.changeControllers(menu)
        }
    }
}

extension LeftMenuController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        
        cell.imgSideMenuIcon.image = UIImage(named:menuArray[indexPath.row]["icon"]!)
        cell.lblTitle.text = menuArray[indexPath.row]["type"]
        cell.lblTitle.textColor = UIColor.init(hexString: "#554C5B")
        if lastSelectedCell == nil {
            lastSelectedCell = cell
            lastSelectedCell!.lblTitle.textColor = UIColor.init(hexString: "#C89F68")
            
        }
        else {
            lastSelectedCell!.lblTitle.textColor = UIColor.init(hexString: "#C89F68")
        }
        return cell
    }
    
}

extension LeftMenuController
{
//    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
//    {
//        if index == 0
//        {
//            logOutService()
//        }
//        else if index == 1
//        {
//            alertView.dismiss()
//        }
//    }
}


extension LeftMenuController
{

    func getHomeList() {
        
        let requestParam = self.manager.params()
        self.manager.apiGetCultureList(requestParam, completion: {
            
            if self.manager.isSuccess {
                print(self.manager.data)
                Culture.data = self.manager.data!
            }
        })
    }
    
}

//Location





