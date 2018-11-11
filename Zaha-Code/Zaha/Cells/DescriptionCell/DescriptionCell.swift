//
//  DescriptionTableViewCell.swift
//  VIE
//
//  Created by aurangzaibkhan on 7/3/18.
//  Copyright © 2018 aurangzaibkhan. All rights reserved.
//

import UIKit

enum DescriptionCellTypeEnum :Int {
    case bookingDetailDesc
}

class DescriptionCell: UITableViewCell
{
    @IBOutlet weak var lblDescription: BaseUILabel!
    @IBOutlet weak var lblDescriptionContent: BaseUILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setData(_ type : DescriptionCellTypeEnum) {
        
        var desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sodales et nulla sed mollis. Pellentesque eu lectus vel nulla posuere aliquam. Ut eget justo feugiat, tristique lorem vel, semper tellus. Donec dapibus, enim et dignissim tempor, nibh sapien placerat eros, ac vehicula nisi mauris sed libero. Quisque at nunc sed mauris fringilla fermentum faucibus in odio. Quisque eleifend velit orci, eget ornare eros faucibus vel. Nulla lobortis tellus vel nulla mattis tristique."
        
        switch type {
        case .bookingDetailDesc:
            lblDescription.isHidden = true
            lblDescriptionContent.text = desc
            break
        default:
            print("")
        }
        
    }
    
    
} // end class DescriptionTableViewCell


