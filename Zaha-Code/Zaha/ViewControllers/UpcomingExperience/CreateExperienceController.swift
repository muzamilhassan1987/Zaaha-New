//
//  CreateExperienceController.swift
//  Zaha
//
//  Created by muzamilhassan on 10/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class CreateExperienceController: BaseViewController , StoryBoardHandler {

    
    @IBOutlet weak var txtPrice: BaseUITextField!
    
    @IBOutlet weak var txtVDesc: BaseUITextView!
    @IBOutlet weak var txtLocation: BaseUITextField!
    @IBOutlet weak var txtTime: BaseUITextField!
    @IBOutlet weak var txtType: BaseUITextField!
    @IBOutlet weak var txtCulture: BaseUITextField!
    @IBOutlet weak var txtExpTitle: BaseUITextField!
    @IBOutlet weak var btnBrowsePhoto: BaseUIButton!
    
    @IBOutlet weak var txtUploadPhoto: BaseUITextField!
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.upcommingExperience.rawValue , nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialData()
        setNavBar()
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
        self.title = "CREATE STORY"
        self.navigationController?.isNavigationBarHidden = false
        
//        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        //self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    
    @IBAction func selectPhoto(_ sender: BaseUIButton) {
    }
    @IBAction func selectTime(_ sender: UIButton) {
        
    }
    @IBAction func selectCulture(_ sender: UIButton) {
        
    }
    
    @IBAction func selectType(_ sender: UIButton) {
        
    }
    
    
    @IBAction func createExperience(_ sender: Any) {
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
