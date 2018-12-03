//
//  FilterController.swift
//  Zaha
//
//  Created by muzamilhassan on 03/12/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class FilterController: BaseViewController,StoryBoardHandler {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.home.rawValue , nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        print("Called Action")
        self.dismiss(animated: false) {
            
        }
    }
    @IBAction func applyFilter(_ sender: BaseUIButton) {
        self.dismiss(animated: false) {
            
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
