//
//  ForgetPasswordViewController.swift
//

import UIKit

class ForgetPasswordViewController: BaseViewController, StoryBoardHandler {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue , nil)
    
    @IBOutlet weak var txtEmail: BaseUITextField!
    let manager = RegisterManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()

        // Do any additional setup after loading the view.
    }
    func setNavBar()
    {
        self.title = "FORGOT PASSWORD"
        self.navigationController?.isNavigationBarHidden = false
        
        //        let img = UIImage.init(named: "home_backArrow")?.flipIfNeeded()
        //self.addBarButtonItemWithImage(img!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitButtonTapped(_ sender: Any)
    {
        let status = validateForm()
        
        if status.0 == false
        {
            Alert.showMsg(msg: status.1)
        }
        else
        {
            let parameters = [
                "email" : txtEmail.text!
                ] as [String:Any]
            
            forgotPasswordService(params: parameters, email: txtEmail.text!)
            //getCode(email: txtEmail.text!)
        }
    }
    
    func validateForm() -> (Bool , String)
    {
        let emailText = txtEmail.text
        
        if (emailText?.isEmptyStr())!
        {
            return (false, "Kindly provide email address")
        }
        else if !(emailText?.isValidEmail())!
        {
            return (false, "Kindly provide a valid email address")
        }
        
        return (true, "")
    }

    func forgotPasswordService(params: [String:Any], email: String)
    {
        let requestParams = self.manager.paramsForgotPassword(parameters: params as [String : AnyObject])
        
        print("requestParams: ", requestParams)
        
        self.manager.apiForgotPassword(requestParams, completion: {
            
            if self.manager.isSuccess {
                Alert.showWithCompletion(msg: self.manager.message, completionAction: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            else {
                
                print("failed")
            }
            
        })
    }

    
  
}



