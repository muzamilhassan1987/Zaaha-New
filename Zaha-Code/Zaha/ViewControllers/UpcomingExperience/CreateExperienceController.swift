//
//  CreateExperienceController.swift
//  Zaha
//
//  Created by muzamilhassan on 10/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import CoreLocation

class CreateExperienceController: BaseViewController , StoryBoardHandler , PickerViewControllerSelectedDataDelegate {
    
    @IBOutlet weak var txtPrice: BaseUITextField!
    @IBOutlet weak var txtVDesc: BaseUITextView!
    @IBOutlet weak var txtLocation: BaseUITextField!
    @IBOutlet weak var txtTime: BaseUITextField!
    @IBOutlet weak var txtType: BaseUITextField!
    @IBOutlet weak var txtCulture: BaseUITextField!
    @IBOutlet weak var txtExpTitle: BaseUITextField!
    @IBOutlet weak var btnBrowsePhoto: BaseUIButton!
    let datePicker = UIDatePicker()
    var imgExp : UIImage? = nil
    var params = [String : String?]()
    var isImageUploaded = false
    
    var cultureManager = CultureManager()
    var typeListManager = TypeListManager()
    var createExpManager = ExperienceManager()
    var cultureNameArray = [String]()
    var typeNameArray = [String]()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var createExpBtn: BaseUIButton!
    var createExpRequestModel = CreateExperienceRequest()
    
    
    @IBOutlet weak var txtUploadPhoto: BaseUITextField!
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.upcommingExperience.rawValue , nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialData()
        setNavBar()
        createExpRequestModel.latitude = "0"
        createExpRequestModel.longitude = "0"
        
        /// Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //        addPickerForCultureList()
        getCultureList()
        getTypeList()
        addDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    func setInitialData() {
        
        setLeftPaddingTextField(txtLocation)
        setLeftPaddingTextField(txtTime)
        setLeftPaddingTextField(txtType)
        setLeftPaddingTextField(txtCulture)
        setLeftPaddingTextField(txtExpTitle)
        setLeftPaddingTextField(txtUploadPhoto)
        setLeftPaddingTextField(txtPrice)
    }
    
    
    func setNavBar()
    {
        self.title = "CREATE EXPERIENCE"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func selectPhoto(_ sender: BaseUIButton) {
         self.showImagePicker()
    }
    
    @IBAction func selectCulture(_ sender: UIButton) {
        addPickerForCultureList()
    }
    
    @IBAction func selectType(_ sender: UIButton) {
        addPickerForTypeList()
    }
    
    
    @IBAction func createExperience(_ sender: Any) {
        
        let isValid = checkValidationForCreateExp()
        
        if isValid{
        params = ["experience_type_id":createExpRequestModel.experienceTypeId,
                  "culture_id":createExpRequestModel.cultureId,
                  "experience_charges":createExpRequestModel.amount,
                  "title":createExpRequestModel.title,
                  "description":createExpRequestModel.descriptionField,
                  "latitude":createExpRequestModel.latitude,
                  "longitude":createExpRequestModel.longitude,
                  "location":createExpRequestModel.location,
                  "publish_date":createExpRequestModel.publishDate,
                  "publish_time":createExpRequestModel.publishTime,
                  "no_seats":"8"
        ]
        //createExpRequestModel?.explorers
        
        let imgData = imgExp!.jpegData(compressionQuality: 0.1)
        let imageExperience = UIImage(data: imgData!)!
        
        let requestParam = self.createExpManager.paramsCreateExp(parameters: params as [String : AnyObject], img: imageExperience)
        
        self.createExpManager.creteExpApiWithImage(requestParam,imageData: imgData!, completion: {
            
            if self.createExpManager.isSuccess {
                Alert.showWithCompletion(msg: self.createExpManager.message, completionAction: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            else {
                
                print("failed")
            }
        })
        }else{
            Alert.showMsg(msg: "Please fill all the field to create experience")
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
    
    func getSelectedArrayIndex(selectedIndex: Int, andSelectedValue: String, andPickerType: PickerType) {
        
        switch andPickerType
        {
        case .cultureList:
            let culture = Culture.data![selectedIndex]
            print(culture.id)
            self.txtCulture.text = andSelectedValue
            createExpRequestModel.cultureId = "\(culture.id)"
            break
            
        case .typeList:
            let type = Type.data![selectedIndex]
            print(type.id)
            self.txtType.text = andSelectedValue
            createExpRequestModel.experienceTypeId = "\(type.id)"
            break
            
        default:
            print("")
        }
    }
}


extension CreateExperienceController{
    
    func getCultureList() {
        
        let requestParam = self.cultureManager.params()
        self.cultureManager.apiGetCultureList(requestParam, completion: {
            
            if self.cultureManager.isSuccess {
                print(self.cultureManager.data)
                Culture.data = self.cultureManager.data!
                for cultureName in Culture.data!{
                    self.cultureNameArray.append(cultureName.title!)
                }
                
            }
        })
    }
    
    func addPickerForCultureList(){
        let storyboard = UIStoryboard(name: "PickerViewModule", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.arrayOfData = self.cultureNameArray
        vc.pickerViewControllerSelectedDataDelegate = self as! PickerViewControllerSelectedDataDelegate
        vc.pickerType = .cultureList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension CreateExperienceController{
    
    func getTypeList() {
        
        let requestParam = self.typeListManager.params()
        self.typeListManager.apiGetTypeList(requestParam, completion: {
            
            if self.typeListManager.isSuccess {
                print(self.typeListManager.data)
                Type.data = self.typeListManager.data!
                for typeName in Type.data!{
                    self.typeNameArray.append(typeName.title!)
                }
                
            }
        })
    }
    
    func addPickerForTypeList(){
        let storyboard = UIStoryboard(name: "PickerViewModule", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.arrayOfData = self.typeNameArray
        vc.pickerViewControllerSelectedDataDelegate = self as! PickerViewControllerSelectedDataDelegate
        vc.pickerType = .typeList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension CreateExperienceController{
    
    func addDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtTime.inputAccessoryView = toolbar
        txtTime.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        txtTime.text = formatter.string(from: datePicker.date)

        let timeDateArray = txtTime.text!.characters.split{$0 == " "}.map(String.init)
        var date: String = timeDateArray[0]
        var time: String? = timeDateArray.count > 1 ? timeDateArray[1] : nil
        
        createExpRequestModel.publishDate = date
        createExpRequestModel.publishTime = time
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}



extension CreateExperienceController: ImagePickerPresentable {
    
    func getImage(img: UIImage?) {
        
        self.imgExp = img
        print(img)
        txtUploadPhoto.text = "image Uploaded"
        isImageUploaded = true
    }
    
    func selectedImage(data: Data?) {
        //here is your image data...
        print(data)
    }
    
    
}

extension CreateExperienceController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtExpTitle
        {
            createExpRequestModel.title = textField.text
        }
        else if textField == txtPrice{
            createExpRequestModel.amount = textField.text
        }
        else if textField == txtLocation{
            createExpRequestModel.location = textField.text
        }
    }
}

extension CreateExperienceController:CLLocationManagerDelegate{
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        createExpRequestModel.latitude = "\(locValue.latitude)"
        createExpRequestModel.longitude = "\(locValue.longitude)"
    }
    
}

extension CreateExperienceController{
    func checkValidationForCreateExp() -> Bool {
        createExpRequestModel.descriptionField = txtVDesc.text
        
        guard let expId = createExpRequestModel.experienceTypeId, !expId.isEmpty else {
            return false
        }
        
        guard let cultureId = createExpRequestModel.cultureId, !cultureId.isEmpty else {
            return false
        }
        
        guard let amount = createExpRequestModel.amount, !amount.isEmpty else {
            return false
        }
        
        guard let expTitle = createExpRequestModel.title, !expTitle.isEmpty else {
            return false
        }
        
        
        guard let descriptionField = createExpRequestModel.descriptionField, !descriptionField.isEmpty else {
            return false
        }
        
        guard let location = createExpRequestModel.location, !location.isEmpty else {
            return false
        }
        
        guard let publishDate = createExpRequestModel.publishDate, !publishDate.isEmpty else {
            return false
        }
        
        if (!isImageUploaded){
            return false
        }
        
        return true
    }
}
