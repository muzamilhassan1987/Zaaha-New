//
//  BookingStatusCell.swift
//  Zaha
//
//  Created by muzamilhassan on 21/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class BookingStatusCell: UITableViewCell {
    
    @IBOutlet weak var imgStatus: BaseUIImageView!
    @IBOutlet weak var lblStatus: BaseUILabel!
    var detailType = BookingDetailEnum.none
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data : HomeExperience!, type : BookingDetailEnum!) {
        
        print(type)
        self.detailType = type
       
        
        switch detailType {
            
        case .none:
            self.setStatusText(data.bookingStatus!)
            break
        case .booking:
            break
        case .upcomingExperience:
            self.setStatusText(data.bookingStatus!)
            break
        default:
            print("")
        }
        
    }
    
    func setStatusText(_ value : Int) {
        
        switch value {
        case BookingStatus.Available.rawValue:
            lblStatus.text = ""
            break
        case BookingStatus.Pending.rawValue:
            lblStatus.text = "Pending"
            break
        case BookingStatus.Rejected.rawValue:
            lblStatus.text = "Rejected"
            break
        case BookingStatus.Completed.rawValue:
            lblStatus.text = "Completed"
            break
        case BookingStatus.Cancel.rawValue:
            lblStatus.text = "Cancel"
            break
        default:
            print("")
        }
        
        
    }
}
