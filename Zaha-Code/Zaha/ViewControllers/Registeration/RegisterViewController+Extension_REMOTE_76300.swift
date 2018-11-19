
import UIKit
extension RegisterViewController {
    
    func  validateSignupFormScroll(){
        let fv = FormValidator()
        
        var parameters = [String : String]()
       // self.imgProfile = UIImage(named: "bg-home")
        let firstName = fv.validateName(title: txtFirstName.placeholder!, text: txtFirstName.text!)
        let lastName = fv.validateName(title: txtLastName.placeholder!, text: txtLastName.text!)
        let email = fv.validateEmail(title: txtEmail.placeholder!, text: txtEmail.text!)
        let password = fv.validatePassword(title: txtPassword.placeholder!, text: txtPassword.text!)
        let confirmPassword = fv.validateConfirmPassword(title: txtConfirmPassword.placeholder!, pwd: txtPassword.text!, cpwd: txtConfirmPassword.text!)
       
        if (firstName.0 == false) {
            Alert.showMsg(msg: firstName.1)
            return
        }
        if (lastName.0 == false) {
            Alert.showMsg(msg: lastName.1)
            return
        }
        if (email.0 == false) {
            Alert.showMsg(msg: email.1)
            return
        }
        if (password.0 == false) {
            Alert.showMsg(msg: password.1)
            return
        }
        if (confirmPassword.0 == false) {
            Alert.showMsg(msg: confirmPassword.1)
            return
        }
        guard let imgProfile = self.imgProfile else {
            Alert.showMsg(msg: "Select profile image")
            return
        }
       // UIImage.jp
        self.imgData = imgProfile.jpegData(compressionQuality: 0.1)
        
        parameters.updateValue(txtFirstName.text!, forKey: "first_name")
        parameters.updateValue(txtLastName.text!, forKey: "last_name")
        parameters.updateValue(txtEmail.text!, forKey: "email")
        parameters.updateValue(txtPassword.text!, forKey: "password")
        parameters.updateValue("ios", forKey: "device_type")
        parameters.updateValue("123456789", forKey: "device_token")
        print(parameters)
       
        doSignup(params: parameters, imgData: self.imgData!)
    }
    
    func  validateSignupForm(){
         let fv = FormValidator()
      
         var parameters = [String : String]()
      
        for data in self.dataArray! {
             guard let dict = data as? NSMutableDictionary else {return}
            
            switch dict["kind"]  as! String  {
            case "name" :
                let name = fv.validateName(title: getString(dict["title"]), text: getString(dict["text"]))
               if name.0 == false{
                    Alert.showMsg(msg: name.1)
                    return
                }else{
                
                  parameters.updateValue(getString(dict["text"]), forKey: "name")
                }
                
            case "email" :
                let email = fv.validateEmail(title: getString(dict["title"]), text: getString(dict["text"]))
                
                if email.0 == false{
                    Alert.showMsg(msg: email.1)
                    return
                }else{
                    parameters.updateValue(getString(dict["text"]), forKey: "email")
                }
                
            case "phone" :
                let code = fv.validateCode(title: "Country Code", text: getString(dict["text"]))
                 let phone = fv.validatePhoneNo(title: getString(dict["title"]), text: getString(dict["textNo"]))
                if code.0 == false{
                    Alert.showMsg(msg: code.1)
                    return
                }
                else if phone.0 == false{
                    Alert.showMsg(msg: phone.1)
                    return
                }else{
                    let combined =  getString(dict["text"]) + "-" + getString(dict["textNo"])
                    parameters.updateValue(combined, forKey: "phone")
                }
                
            case "pwd" :
                let pwd = fv.validatePassword(title: getString(dict["title"]), text: getString(dict["text"]))
                
                if pwd.0 == false{
                    Alert.showMsg(msg: pwd.1)
                    return
                }else{
                    
                    parameters.updateValue(getString(dict["text"]), forKey: "password")
                }
                
            case "cpwd" :
                let cpwd = fv.validateConfirmPassword(title: getString(dict["title"]), pwd: parameters["password"]!, cpwd: getString(dict["text"]))
                
                if cpwd.0 == false{
                    Alert.showMsg(msg: cpwd.1)
                    return
                }else{
                    
                    parameters.updateValue(getString(dict["text"]), forKey: "password_confirmation")
                }
                
            case "checkbox" :
                let check = fv.validateAcceptTerm(title: getString(dict["title"]), status: getBool(dict["isAccept"]))
                
                if check.0 == false{
                    Alert.showMsg(msg: check.1)
                    return
                }
              
            default :
                break
            }
        }
        
   
         parameters.updateValue("ios", forKey: "device_type")
         parameters.updateValue("123456789", forKey: "device_token")
       // doSignup(params: parameters)
 }

    
    func getString(_ any : Any?) -> String {
        
        return any as? String ?? ""
    }
    
    func getBool(_ any : Any?) -> Bool {
        
        return any as? Bool ?? false
    }
    
}

// MARK: - Networking
extension RegisterViewController {
    
    func doSignup(params : [String : String], imgData : Data) {
        let imageProfile = UIImage(data: self.imgData!)!
        
        //let requestParam = self.manager.params(parameters: params as [String : AnyObject])
        let requestParam = self.manager.paramsWithImage(parameters: params as [String : AnyObject], img: imageProfile)
        print(imageProfile)
        print(params)
        print(requestParam)
        print(requestParam.images)
        print(requestParam.endpoint)
    
        self.manager.apiWithImage(requestParam,imageData: imgData, completion: {
            
            if self.manager.isSuccess {
                //CurrentUser.data = self.manager.userData
              //  FP.emailUser = (self.manager.userData?.email!)!
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



