//
//  ButtonsCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/11/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class ButtonsCell: UITableViewCell {

    @IBOutlet weak var btnBook: BaseUIButton!
    @IBOutlet weak var btnReject: BaseUIButton!
    @IBOutlet weak var btnConfirm: BaseUIButton!
    var type = BookingDetailEnum.none
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ type : BookingDetailEnum) {
        
        self.type = type
        switch type {
            
        case .none:
            btnReject.isHidden = true
            btnConfirm.isHidden = true
            break
            
        case .booking:
            btnBook.isHidden = true
            break
            
        case .upcomingExperience:
            btnReject.isHidden = true
            btnConfirm.isHidden = true
            break
        default:
            print("")
        }
        
    }
    
    @IBAction func bookExperience(_ sender: Any) {
        
        
    }
    
    
}
