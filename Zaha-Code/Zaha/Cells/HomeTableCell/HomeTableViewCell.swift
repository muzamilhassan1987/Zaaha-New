//
//  HomeTableViewCell.swift
//  Zaha
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum HomeTableViewType : Int {
    case viewProfile
    case homeList
    case stories
}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imgVideoIcon: UIImageView!
    
    @IBOutlet weak var layoutTopPadding: NSLayoutConstraint!
    @IBOutlet weak var viewFiveLabels: UIView!
    @IBOutlet weak var viewTwoLabel: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ type : HomeTableViewType) {
        
        viewTwoLabel.isHidden = true
        viewFiveLabels.isHidden = true
        imgVideoIcon.isHidden = true
        switch type {
        case .viewProfile:
            viewTwoLabel.isHidden = false
            imgVideoIcon.isHidden = true
            layoutTopPadding.constant = 20.0
            break
        case .stories:
            viewTwoLabel.isHidden = false
            imgVideoIcon.isHidden = true
            layoutTopPadding.constant = 20.0
            break
        case .homeList:
            viewFiveLabels.isHidden = false
            imgVideoIcon.isHidden = false
            break
        default:
            print("")
        }
    }
    
}
