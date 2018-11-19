//
//  AmenitiesCollectionCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/11/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class AmenitiesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var stackRating: UIStackView!
    
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
    
    static let pastExpDetailData =
        [AmentiesCellData(image: "upcomingExp_nameIcon", title: "Ali Ahmed"),
         AmentiesCellData(image: "", title: ""),
         AmentiesCellData(image: "upcomingExp_locationIcon", title: "Dubai Media City"),
         AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: "star"),
         AmentiesCellData(image: "myExp_ExplorerIcon", title: "08 Explorers"),
//         AmentiesCellData(image: "upcomingExp_priceIcon", title: "AED 250"),
            AmentiesCellData(image: "upcomingExp_TimeIcon", title: "11 Sep 2018"),
             AmentiesCellData(image: "myExp_CultureIcon", title: "Arabic Culture"),
         AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: "Type of experience"),
         
         ]
    
//    static func setAmenitiesData(_ data : HomeExperience!) {
//        
//        
//        
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setData(_ data:AmentiesCellData) {
    
        stackRating.isHidden = true
        imgIcon.image = UIImage(named: data.image)
        lblTitle.text = data.title
        if(data.image == "star") {
            lblTitle.text = ""
            stackRating.isHidden = false
        }
        
    }
}


struct AmentiesCellData {
    var image: String
    var title: String
    
    func printName() {
        print("\(self.image) \(self.title)")
    }
}
struct AmentiesCellDataTest {
    var maestroName: String
    var location: String
    var rating : String
    var time : String
    var explorersCount : String
    var experienceType : String
    var culture : String
    func printName() {
        print("\(self.maestroName) \(self.culture)")
    }
}
