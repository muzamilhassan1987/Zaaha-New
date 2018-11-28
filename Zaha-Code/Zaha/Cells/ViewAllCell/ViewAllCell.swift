//
//  ViewAllCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/10/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

protocol ViewAllCellDelegate: class
{
    func viewAllClick(_ type : ViewAllEnum)
}

enum ViewAllEnum : Int {
    case none
    case photo
    case video
}

class ViewAllCell: UITableViewCell {

    weak var viewAllCellDelegate: ViewAllCellDelegate?
    @IBOutlet weak var lblTitle: BaseUILabel!
    var data:NSMutableDictionary?
    var type = ViewAllEnum.none
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data :NSMutableDictionary) {
        
        self.data = data
        let enumType = data["enumType"] as? String
        let type:Int = Int(enumType!) ?? 0
        self.type = ViewAllEnum(rawValue: type)!
        print(enumType)
        if (type == 1) {
            lblTitle.text = "Photos"
        }
        else if (type == 2) {
            lblTitle.text = "Videos"
        }
        //print(identifier)
//        switch type {
//        case .photo:
//            lblTitle.text = "Photos"
//            break
//        case .video:
//            lblTitle.text = "Videos"
//            break
//        default:
//            print("")
//        }
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
    
    @IBAction func viewAll(_ sender: Any) {
        viewAllCellDelegate?.viewAllClick(self.type)
        
    }
}
