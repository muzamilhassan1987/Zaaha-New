//
//  BaseNavigationController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/20/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, StoryBoardHandler
{
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.main.rawValue, nil)
    
    let mainView = UIView()
    let lblTitle = UILabel()
    var btnBack : UIButton?
    var btnHome : UIButton?
    var isInternal = false
    //var controller: controllers!
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.default
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.isEnabled = false
//        self.navigationBar.barTintColor = UIColor.black

        let navigationBar = self.navigationBar
       // navigationBar.setBackgroundImage(#imageLiteral(resourceName: "BarBackground"),
                      //                   for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barTintColor = UIColor.init(hexString: "##575756")
//        navigationBar.backItem?.hidesBackButton = true
//        self.navigationItem.hidesBackButton = true
        createMainView()
        createTitleLabel()
//        if controller == Controllers.ChaletDetail
//        {
//            self.navigationBar.barTintColor = UIColor.clear
//        }
//        else
//        {
//            self.navigationBar.barTintColor = AppConstants.blueNavBar
//        }
        
        self.title = ""
    }
    
    
    func createMainView() {
        
        navigationBar.backgroundColor = UIColor.green
        mainView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44 + DesignUtility.getValueFromRatio(30))
       // let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44 + DesignUtility.getValueFromRatio(30)))
        mainView.backgroundColor = UIColor.clear
        navigationBar.addSubview(mainView)
        
        
    }
    func createTitleLabel() {
        
        lblTitle.frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        let titleFont = UIFont.init(name: "FuturaStd-Medium", size: DesignUtility.getFontSize(fSize: 18))
        lblTitle.font = titleFont!
        lblTitle.textColor = UIColor.white
        lblTitle.textAlignment = .center
        mainView.addSubview(lblTitle)
       // let barBgColor = UIColor.init(hexString: "#707070")
        
        
    }
    func createBackButton() {
        
        btnBack = UIButton()
        let img = UIImage.init(named: "home_backArrow")?.flipIfNeeded()
        btnBack?.setImage(img, for: .normal)
        btnBack?.frame = CGRect(x: 20, y: 0, width: DesignUtility.getFontSize(fSize: 44), height: DesignUtility.getFontSize(fSize: 44))
        btnBack?.center.y = mainView.center.y
        btnBack?.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        mainView.addSubview(btnBack!)
        
        
    }

    func createHomeButton(target:UIViewController, _ selector:Selector) {
        
        btnHome = UIButton()
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        btnHome?.setImage(menuImg, for: .normal)
        btnHome?.frame = CGRect(x: 20, y: 0, width: DesignUtility.getFontSize(fSize: 44), height: DesignUtility.getFontSize(fSize: 44))
        btnHome?.center.y = mainView.center.y
        btnHome?.addTarget(target, action: selector, for: .touchUpInside)
        mainView.addSubview(btnHome!)
        
        
    }
   
    
    
    func createButton<T: CustomNavBarProtocol>(_ image:UIImage,_ postion: T, _ target:UIViewController, _ selector:Selector) {
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(image, for: .normal)
        btn1.frame = CGRect(x: 0, y: mainView.frame.width - 20 - DesignUtility.getValueFromRatio(44), width: DesignUtility.getValueFromRatio(44), height: DesignUtility.getValueFromRatio(44))
        
        btn1.addTarget(target, action: selector, for: .touchUpInside)
        
        if let postion = postion as? CustomNavBarEnum.CustomBarButtonItemPosition {
            
            switch postion {
            case .BarButtonItemPositionLeft:
                btn1.frame = CGRect(x: 20, y: 0, width: DesignUtility.getValueFromRatio(44), height: DesignUtility.getValueFromRatio(44))
                break
                
            case .BarButtonItemPositionRight:
                btn1.frame = CGRect(x: mainView.frame.width - 20 - DesignUtility.getValueFromRatio(44), y: 0, width: DesignUtility.getValueFromRatio(44), height: DesignUtility.getValueFromRatio(44))
                break
            }
        
        
        }
        btn1.center.y = mainView.center.y
        mainView.addSubview(btn1)
        
    }
    @objc func goBack() {
        
        self.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
//        for btn in mainView.subviews {
//            if let btn1 = btn as? UIButton {
//                btn1.removeFromSuperview()
//            }
//        }
    }
    
    func test()
    {
        
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close:")
        //        this.na
        //        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
        //        style:UIBarButtonItemStyleBordered
        //        target:self
        //        action:@selector(close:)];
        
    }
}
