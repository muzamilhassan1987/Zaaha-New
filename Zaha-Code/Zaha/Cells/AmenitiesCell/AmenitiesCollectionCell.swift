//
//  AmenitiesCollectionCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/11/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class AmenitiesCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var lblTitle: BaseUILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    static let bookingDetailData =
        [AmentiesCellData(image: "upcomingExp_nameIcon", title: "Ali Ahmed"),
        AmentiesCellData(image: "", title: ""),
        AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: "Explorer Rating"),
                ]
    
    static let upcomingDetailData =
        [AmentiesCellData(image: "upcomingExp_nameIcon", title: "Ali Ahmed"),
         AmentiesCellData(image: "", title: ""),
         AmentiesCellData(image: "upcomingExp_locationIcon", title: "Dubai Media City"),
         AmentiesCellData(image: "upcomingExp_priceIcon", title: "AED 250"),
         AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: "Type of experience"),
         AmentiesCellData(image: "upcomingExp_TimeIcon", title: "11 Sep 2018"),
         ]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setData(_ data:AmentiesCellData) {
    
        imgIcon.image = UIImage(named: data.image)
        lblTitle.text = data.title
        
    }
}


struct AmentiesCellData {
    var image: String
    var title: String
    
    func printName() {
        print("\(self.image) \(self.title)")
    }
}
