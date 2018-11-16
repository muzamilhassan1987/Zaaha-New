//
//  AboutController.swift
//  Zaha
//
//  Created by muzamilhassan on 09/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
enum AboutType : Int {
    case none
    case about
    case terms
    case privacy
}


class AboutController: BaseViewController , StoryBoardHandler {

    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblDesc: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    var type = AboutType.none
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.setting.rawValue , nil)
    var isPrivacyPolicy = false
    var cmsType  = ""
    var manager = CMSManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialData()
        
        //setNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getTerms()
    }
    
    
    func setInitialData() {
        
        var title = ""
        var subTitle = ""
        var desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sodales et nulla sed mollis. Pellentesque eu lectus vel nulla posuere aliquam. Ut eget justo feugiat, tristique lorem vel, semper tellus. Donec dapibus, enim et dignissim tempor, nibh sapien placerat eros, ac vehicula nisi mauris sed libero. Quisque at nunc sed mauris fringilla fermentum faucibus in odio. Quisque eleifend velit orci, eget ornare eros faucibus vel. Nulla lobortis tellus vel nulla mattis tristique."
        switch type {
        case .none:
            break
            
        case AboutType.about:
            title = "About Us"
            subTitle = "Zoha - About Us"
            cmsType = "about_us"
            desc = ""
            break
            
        case .terms:
            title = "Terms & Conditions"
            subTitle = "Zoha - Terms & Conditions"
            cmsType = "term_condition"
            desc = ""
            break
            
        case .privacy:
            title = "Privacy Policy"
            subTitle = "Zoha - Privacy Policy"
            desc = ""
             cmsType = "privacy_policy"
            break
        default:
            print("")
        }
        
        
        lblTitle.text = title
        lblDesc.text = desc
        lblSubtitle.text = subTitle
    }
    
    
    func getCMSData() {
        
        
        
    }
    
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        print("Called Action")
        self.dismiss(animated: false) {
            
        }
    }
    func setNavBar()
    {
        if(isPrivacyPolicy == true) {
            self.title = "Pr"
        }
        else{
            
        }
        
        self.navigationController?.isNavigationBarHidden = false
        
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
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
extension AboutController{
    
    func getTerms() {
        
        let parameters = [
            "type" : cmsType
            ] as [String : String]
        print(parameters)
        let requestParam = self.manager.paramsCMS(parameters: parameters as [String : AnyObject])
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                
                self.lblDesc.attributedText = self.manager.htmlString.html2AttributedString
                //self.lblDesc.text = self.manager.data?.descriptionField!
//                print(self.manager.htmlString)
//                self.txtViewTerms.attributedText = self.manager.htmlString.html2AttributedString
            }
            else {
                
            }
        })
    }
}
