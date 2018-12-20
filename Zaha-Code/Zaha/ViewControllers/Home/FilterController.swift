//
//  FilterController.swift
//  Zaha
//
//  Created by muzamilhassan on 03/12/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func filterClickedWithDataDictionary(_ filterDictionary:[String:String])
}


class FilterController: BaseViewController,StoryBoardHandler {
    
    var filterDelegate : FilterDelegate?
    var cultureManager = CultureManager()
    var expMangager = ExperienceManager()
    var typeListManager = TypeListManager()
    
    var typeNameArray =  [TypeData]()
    var cultureNameArray = [CultureData]()
    var maestroNameArray = [MaestroResult]()
    
    var selectedTypesId : Int?
    var selectedMaestroId : Int?
    var selectedCultureId :Int?
    var selectedDate : String?
    let datePicker = UIDatePicker()
    
    var filterDataDictionary = ["culture_id":"","masteroes_id":"","experience_type_id":"","date":"","search":"","type":""]
    
    
    @IBOutlet weak var txtMaestro: UITextField!
    @IBOutlet weak var txtCulture: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtTypes: UITextField!
    @IBOutlet weak var txtSearch: UITextField!
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.home.rawValue , nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCultureList()
        getMaestroList()
        getTypeList()
        addDatePicker()
        // Do any additional setup after loading the view.
    }
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        print("Called Action")
        self.dismiss(animated: false) {
            
        }
    }
    @IBAction func applyFilter(_ sender: BaseUIButton) {
        let validParam = validateFilterParams()
        if validParam{
            self.dismiss(animated: false) {
                self.filterDelegate?.filterClickedWithDataDictionary(self.filterDataDictionary)
            }
        }else{
              Alert.showMsg(msg: "filter can only be applied, if some thing is selected")
        }
    }
    
    @IBAction func addCultureList(_ sender: Any) {
        addPickerForCultureList()
    }
    
    @IBAction func clearSearchButtonClicked(_ sender: Any) {
        self.txtSearch.text = ""
    }
    
    @IBAction func addMaestroList(_ sender: Any) {
        addPickerForMaestroList()
    }
    
    @IBAction func addTypeList(_ sender: Any) {
        addPickerForTypeList()
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


extension FilterController{
    
    func getCultureList() {
        
        let requestParam = self.cultureManager.params()
        self.cultureManager.apiGetCultureList(requestParam, completion: {
            
            if self.cultureManager.isSuccess {
                self.cultureNameArray = self.cultureManager.data!
            }
        })
    }
    
    func addPickerForCultureList(){
        var cultureList = [String]()
        
        for cultureName in self.cultureNameArray{
            cultureList.append(cultureName.title!)
        }
        
        
        RPicker.selectOption(dataArray: cultureList) { (selctedText, atIndex) in
            let culture = self.cultureNameArray[atIndex]
            print(culture.id)
            self.txtCulture.text = selctedText
            self.selectedCultureId = culture.id
        }
    }
    
    
    
    func getMaestroList() {
        
        let requestParam = self.expMangager.getMaestroNamesParams()
        self.expMangager.apiGetMaestro(requestParam, completion: {
            
            if self.expMangager.isSuccess {
                print(self.expMangager.maestroNameData)
                self.maestroNameArray = self.expMangager.maestroNameData!
                
            }
        })
    }
    
    func addPickerForMaestroList(){
        var maestroList = [String]()
        
        for maestroName in self.maestroNameArray{
            maestroList.append(maestroName.firstName!)
        }
        
        RPicker.selectOption(dataArray: maestroList) { (selctedText, atIndex) in
            let maestro = self.maestroNameArray[atIndex]
            self.txtMaestro.text = selctedText
            self.selectedMaestroId = maestro.id
        }
    }
    
    func getTypeList() {
        
        let requestParam = self.typeListManager.params()
        self.typeListManager.apiGetTypeList(requestParam, completion: {
            
            if self.typeListManager.isSuccess {
                print(self.typeListManager.data)
                self.typeNameArray = self.typeListManager.data!
                
            }
        })
    }
    
    func addPickerForTypeList(){
        var typeList = [String]()
        
        for typeName in  self.typeNameArray{
            typeList.append(typeName.title!)
        }
        
        RPicker.selectOption(dataArray: typeList) { (selctedText, atIndex) in
            let type = self.typeNameArray[atIndex]
            print(type.id)
            self.txtTypes.text = selctedText
            self.selectedTypesId = type.id
        }
    }
}


extension FilterController{
    
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
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        txtTime.text = formatter.string(from: datePicker.date)
        
        let timeDateArray = txtTime.text!.characters.split{$0 == " "}.map(String.init)
        var date: String = timeDateArray[0]
        var time: String? = timeDateArray.count > 1 ? timeDateArray[1] : nil
        selectedDate = date
        //        createExpRequestModel.publishDate = date
        //        createExpRequestModel.publishTime = time
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func validateFilterParams() -> Bool {
        guard let txtSearch = txtSearch.text, !txtSearch.isEmpty, (self.filterDataDictionary.updateValue(txtSearch, forKey: "search") != nil) else {
            return false
        }
        
        guard let txtMaestro = txtMaestro.text, !txtMaestro.isEmpty, (self.filterDataDictionary.updateValue("\(selectedMaestroId)", forKey: "masteroes_id") != nil) else {
            return false
        }
        
        guard let txtCulture = txtCulture.text, !txtCulture.isEmpty , (self.filterDataDictionary.updateValue("\(selectedCultureId)", forKey: "culture_id") != nil)else {
            return false
        }
        
        guard let txtTime = txtTime.text, !txtTime.isEmpty , (self.filterDataDictionary.updateValue("\(selectedDate)", forKey: "date") != nil)else {
            return false
        }
        
        guard let txtTypes = txtTypes.text, !txtTypes.isEmpty , (self.filterDataDictionary.updateValue("\(selectedTypesId)", forKey: "experience_type_id") != nil) else {
            return false
        }
        
        return true
    }
}
