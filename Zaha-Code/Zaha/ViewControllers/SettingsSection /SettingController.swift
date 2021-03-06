//
//  SettingController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/8/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class SettingController: BaseViewController , StoryBoardHandler {
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.setting.rawValue , nil)
    
    @IBOutlet weak var btnNotification: BaseUIButton!
    @IBOutlet weak var tblSetting: UITableView!
    var manager = RegisterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNavBar()
        setNotificationButton()
       // tblSetting.estimatedRowHeight = 200.0
      //  tblSetting.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    func setNotificationButton() {
        if (CurrentUser.data?.isNotify! == "1") {
            btnNotification.setImage(UIImage(named:"notificationon"), for: .normal)
        }
        else {
            btnNotification.setImage(UIImage(named:"notificationoff"), for: .normal)
        }
    }
    @IBAction func showTerms(_ sender: Any) {
        let controller = AboutController.loadVC()
        controller.type = AboutType.terms
        controller.view.backgroundColor = UIColor.clear
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
            
        }
    }
    @IBAction func showAbout(_ sender: UIButton) {
        let controller = AboutController.loadVC()
        controller.type = AboutType.about
        controller.view.backgroundColor = UIColor.clear
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
            
        }
    }
    
    @IBAction func showPrivacyPolicy(_ sender: Any) {
        
        let controller = AboutController.loadVC()
        controller.type = AboutType.privacy
        controller.view.backgroundColor = UIColor.clear
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
        
        }
//        self.view.addSubview(controller.view)
        
    }
    func setNavBar()
    {
        baseNavigation?.lblTitle.text = "SETTINGS"
        self.navigationController?.isNavigationBarHidden = false
        
        //let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        //baseNavigation?.createButton(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseNavigation?.createHomeButton(target: self, #selector(actionMenuButton))
    }
    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func changePassword(_ sender: BaseUIButton) {
        
        let controller = ChangePasswordController.loadVC()
//        controller.type = AboutType.privacy
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
            
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        Alert.showWithTwoActions(title: "Logout", msg: "Are you sure you want to logout?", okBtnTitle: "Yes", okBtnAction: {
                self.logoutService()
//            self.updatePushStatus()
        }, cancelBtnTitle: "No") {
            
        }
    }
    func doLogout() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let userDefault = UserDefaults.standard
        userDefault.set(false, forKey: Login.isLoggedIn)
        router.goToLoginScreen()
        router.goToLoginScreen()
    }
    
    @IBAction func upDatePush(_ sender: BaseUIButton) {
        
        self.updatePushStatus()
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
extension SettingController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! UITableViewCell
        //        cell.backgroundColor = UIColor.yellow
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //        return 200
    }
    
    
}


extension SettingController{
    
    func logoutService() {
        
        let param = [
            "device_token" :CurrentUser.deviceToken,
            //"deviceType" : 2
            ] as [String:String]
        let requestParam = self.manager.paramsLogout(parameters: param as [String : AnyObject])
        self.manager.apiLogout(requestParam, completion: {
            
            if self.manager.isSuccess {
                self.doLogout()
            }
        })
    }
    
    
    func updatePushStatus() {
        
        var notify = ""
        if (CurrentUser.data?.isNotify! == "1") {
            notify = "0"
        }
        else {
            notify = "1"
        }
        let param = [
            "notify_status" :notify,
            //"deviceType" : 2
            ] as [String:String]
        
        print(CurrentUser.token)
        let requestParam = self.manager.paramsNotificationOnOff(parameters: param as [String : AnyObject])
        self.manager.apiUpdatePushStatus(requestParam, completion: {
            
            if self.manager.isSuccess {
                
                CurrentUser.data?.isNotify! = notify
                print(CurrentUser.data?.isNotify!)
                self.setNotificationButton()
//                Alert.showWithCompletion(msg: self.manager.message, completionAction: {
//                })
            }
        })
    }
    //        if let obj1 = self.manager.data[0] as? HomeExperience {
    //            print(obj1.title)
    //            // obj is a string array. Do something with stringArray
    //        }
    //        if let obj1 = self.manager.data[3] as? HomeStory {
    //            print(obj1.title)
    //            // obj is a string array. Do something with stringArray
    //        }
    
}
