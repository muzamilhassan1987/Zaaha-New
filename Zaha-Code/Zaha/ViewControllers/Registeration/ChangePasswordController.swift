//
//  ChangePasswordController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/18/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class ChangePasswordController: BaseViewController, StoryBoardHandler {

    
    @IBOutlet weak var txtConfirmPassword: BaseUITextField!
    @IBOutlet weak var txtNewPassword: BaseUITextField!
    @IBOutlet weak var txtOldPassword: BaseUITextField!
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue, nil)
    let manager = RegisterManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updatePassword(_ sender: Any) {
        
        validateForm()
    }
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        print("Called Action")
        self.dismiss(animated: true) {
            
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


extension ChangePasswordController {
    
    func validateForm() -> ()
    {
         let fv = FormValidator()
        
         let oldPassword = fv.validatePassword(title: "old password", text: txtOldPassword.text!)
        let newPassword = fv.validatePassword(title: "new password", text: txtNewPassword.text!)
        let confirmPassword = fv.validateConfirmPassword(title: "confirm password", pwd: txtNewPassword.text!, cpwd: txtConfirmPassword.text!)
        
        
        if (oldPassword.0 == false) {
            Alert.showMsg(msg: oldPassword.1)
            return
        }
        if (newPassword.0 == false) {
            Alert.showMsg(msg: newPassword.1)
            return
        }
        if (confirmPassword.0 == false) {
            Alert.showMsg(msg: confirmPassword.1)
            return
        }
        var parameters = [String : String]()
        parameters.updateValue(txtOldPassword.text!, forKey: "old_password")
        parameters.updateValue(txtNewPassword.text!, forKey: "password")
        updatePasswordService(params: parameters)
    }
}

extension ChangePasswordController {
    
    func updatePasswordService(params : [String : String]) {
        
        let requestParam = self.manager.paramsUpdatePasswod(parameters: params as [String : AnyObject])
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                //CurrentUser.data = self.manager.userData
                //  FP.emailUser = (self.manager.userData?.email!)!
                Alert.showWithCompletion(msg: self.manager.message, completionAction: {
                    self.dismiss(animated: true, completion: {
                        
                    })
                })
            }
            else {
                
                print("failed")
            }
        })
        
        
    }
    
    
    
    
}
