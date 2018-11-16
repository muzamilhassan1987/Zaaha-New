//
//  ViewProfileController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/9/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class EditProfileController: BaseViewController, StoryBoardHandler {

    @IBOutlet weak var btnBrowsePhoto: BaseUIButton!
    @IBOutlet weak var txtLastName: BaseUITextField!
    @IBOutlet weak var txtFirstName: BaseUITextField!
    @IBOutlet weak var txtCulture: BaseUITextField!
    
    var imgProfile : UIImage? = nil
    var imgData : Data?
    var selectedCulture : CultureData?
    @IBOutlet weak var btnSave: BaseUIButton!
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue, nil)
    let manager = RegisterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtFirstName.text = CurrentUser.data!.firstName!
        txtLastName.text = CurrentUser.data!.lastName!
        if let cultureId = CurrentUser.data?.cultureId , cultureId > 0 {
            txtCulture.text = CurrentUser.data!.cultureName!
        }
        //setNavBar()
        //setUpTable()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectCulture(_ sender: Any) {
        //let row = ["a","b"]
        let arrCulture = Culture.data!.map { $0.title! }
    
        ActionSheetStringPicker.show(withTitle: "Culture List",
                                     rows: arrCulture,
                                     initialSelection: 0,
                                     doneBlock: { (picker, index, value) in
                                        print(picker as Any)
            print(index)
            print(value)
            self.txtCulture.text = arrCulture[index]
            self.selectedCulture = Culture.data![index]
                                        
        }, cancel: { (picker) in
            
        }, origin: sender)
    }
    
    @IBAction func browsePhoto(_ sender: BaseUIButton) {
        self.showImagePicker()
        
    }
    @IBAction func updateProfile(_ sender: BaseUIButton) {
        validateEditProfile()
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
extension EditProfileController: ImagePickerPresentable {
    
    func getImage(img: UIImage?) {
        
        self.imgProfile = img
        print(img)
    }
    
    func selectedImage(data: Data?) {
        //here is your image data...
        print(data)
    }
    
    
}
extension EditProfileController {
    
    func  validateEditProfile(){
        let fv = FormValidator()
        
        var parameters = [String : String]()
        // self.imgProfile = UIImage(named: "bg-home")
        let firstName = fv.validateName(title: txtFirstName.placeholder!, text: txtFirstName.text!)
        let lastName = fv.validateName(title: txtLastName.placeholder!, text: txtLastName.text!)
        
        if (firstName.0 == false) {
            Alert.showMsg(msg: firstName.1)
            return
        }
        if (lastName.0 == false) {
            Alert.showMsg(msg: lastName.1)
            return
        }
        
        var isImageSelected = false
        if let imgProfile = self.imgProfile {
            isImageSelected = true
            self.imgData = imgProfile.jpegData(compressionQuality: 0.1)
        }
        if let culture = selectedCulture {
            parameters.updateValue(String(culture.id!), forKey: "culture_id")
        }
        parameters.updateValue(txtFirstName.text!, forKey: "first_name")
        parameters.updateValue(txtLastName.text!, forKey: "last_name")
        parameters.updateValue("ios", forKey: "device_type")
        parameters.updateValue(CurrentUser.deviceToken, forKey: "device_token")
        parameters.updateValue(CurrentUser.data!.email!, forKey: "email")
        print(parameters)
        updateProfileService(params: parameters)
    }
    
    
    
}
extension EditProfileController {

    func updateProfileService(params : [String : String]) {
//        let imageProfile = UIImage(data: self.imgData!)!
        
        let requestParam = self.manager.paramsUpdateProfile(parameters: params as [String : AnyObject], img: self.imgData)
        if let imgData = self.imgData {
            let imageProfile = UIImage(data: self.imgData!)!
            self.manager.apiWithImage(requestParam,imageData: imgData, completion: {
                
                if self.manager.isSuccess {
                    CurrentUser.data! = self.manager.userData!
                    Alert.showWithCompletion(msg: self.manager.message, completionAction: {
                        self.dismiss(animated: true) {
                            
                        }
                    })
                }
                else {
                    
                    print("failed")
                }
            })
        }
        else {
            
            self.manager.api(requestParam, completion: {
                
                if self.manager.isSuccess {
                    CurrentUser.data! = self.manager.userData!
                    Alert.showWithCompletion(msg: self.manager.message, completionAction: {
                        self.dismiss(animated: true) {
                            
                        }
                    })
                }
                else {
                    
                    print("failed")
                }
            })
        }
        
        
        
    }
    
    
}
