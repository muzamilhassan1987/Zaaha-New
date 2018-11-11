//
//  ViewProfileController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/9/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class EditProfileController: BaseViewController, StoryBoardHandler {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue, nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setNavBar()
        //setUpTable()
        // Do any additional setup after loading the view.
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
