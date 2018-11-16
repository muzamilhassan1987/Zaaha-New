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
    
    @IBOutlet weak var tblSetting: UITableView!
    var manager = RegisterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNavBar()
       // tblSetting.estimatedRowHeight = 200.0
      //  tblSetting.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showTerms(_ sender: Any) {
        let controller = AboutController.loadVC()
        controller.type = AboutType.terms
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
            
        }
    }
    @IBAction func showAbout(_ sender: UIButton) {
        let controller = AboutController.loadVC()
        controller.type = AboutType.about
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
            
        }
    }
    
    @IBAction func showPrivacyPolicy(_ sender: Any) {
        
        let controller = AboutController.loadVC()
        controller.type = AboutType.privacy
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
        
        }
//        self.view.addSubview(controller.view)
        
    }
    func setNavBar()
    {
        self.title = "SETTINGS"
        self.navigationController?.isNavigationBarHidden = false
        
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        Alert.showWithTwoActions(title: "Logout", msg: "Are you sure you want to logout?", okBtnTitle: "Yes", okBtnAction: {
//                self.logoutService()
            self.updatePushStatus()
        }, cancelBtnTitle: "No") {
            
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
                router.goToLoginScreen(from: self)
            }
        })
    }
    
    
    func updatePushStatus() {
        
        let param = [
            "notify_status" :"0",
            //"deviceType" : 2
            ] as [String:String]
        
        print(CurrentUser.token)
        let requestParam = self.manager.paramsNotificationOnOff(parameters: param as [String : AnyObject])
        self.manager.apiUpdatePushStatus(requestParam, completion: {
            
            if self.manager.isSuccess {
                Alert.showWithCompletion(msg: self.manager.message, completionAction: {
                })
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
