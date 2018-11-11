//
//  BookingCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/7/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var btnView: BaseUIButton!
    @IBOutlet weak var btnStatus: BaseUIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnStatus.backgroundColor = Color.BookStatus.confirmed
        btnView.backgroundColor = Color.BookStatus.view
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
