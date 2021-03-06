
//
//  BookSpecialController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/11/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

@objc protocol SubmitBookingDelegate: class
{
    @objc optional  func submitBooking(_ request : String)
}

class BookSpecialController: BaseViewController, StoryBoardHandler {
    @IBOutlet weak var txtView: BaseUITextView!
    
    weak var submitBookingDelegate: SubmitBookingDelegate?
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.booking.rawValue, nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        print("Called Action")
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        print("Called Action")
        self.dismiss(animated: true) {
            self.submitBookingDelegate?.submitBooking!(self.txtView.text!)
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
