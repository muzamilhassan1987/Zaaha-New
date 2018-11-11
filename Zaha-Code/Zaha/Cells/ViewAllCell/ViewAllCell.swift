//
//  ViewAllCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/10/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum ViewAllEnum : Int {
    case photo
    case video
}

class ViewAllCell: UITableViewCell {

    @IBOutlet weak var lblTitle: BaseUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ type :ViewAllEnum) {
        
        switch type {
        case .photo:
            lblTitle.text = "Photos"
            break
        case .video:
            lblTitle.text = "Videos"
            break
        default:
            print("")
        }
    }
}
