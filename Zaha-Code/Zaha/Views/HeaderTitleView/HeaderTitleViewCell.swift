//
//  HeaderTitleViewCell.swift
//  Zaha
//
//  Created by muzamilhassan on 08/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum HeaderTitleTypeEnum : Int {
    case none
    case viewProfile
    
}

class HeaderTitleViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: BaseUILabel!
    var headerType = HeaderTitleTypeEnum.none
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ type : HeaderTitleTypeEnum, data : Any? = nil) {
        
        
        switch type {
        case .none:
            break
        case .viewProfile:
            let user = data as! UserData
            lblTitle.text = user.firstName! + user.lastName!
            lblTitle.textAlignment = .center
            break
        default:
            print("")
        }
    }
    
    
    
}
