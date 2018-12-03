//
//  AmenitiesTableCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/11/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class AmenitiesTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var detailType = BookingDetailEnum.none
//    var
    var arrAmenities = [AmentiesCellData]()
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmenitiesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AmenitiesCollectionCell")
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(collectionView.bounds.width)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print(collectionView.bounds.width)
        self.updateFrame()
    }

    func updateFrame() {
        
        let flow = UICollectionViewFlowLayout.init()
        var cellSize:CGSize!
        let numberOfCellsPerRow: CGFloat = 2
        //        let width = (collectionView.bounds.width/3) - DesignUtility.getValueFromRatio(7.5)
        flow.minimumLineSpacing = 0//DesignUtility.getValueFromRatio(20)
        let width = (collectionView.frame.width - max(0, numberOfCellsPerRow - 1)*flow.minimumLineSpacing)/2
        cellSize = CGSize(width: width, height: DesignUtility.getValueFromRatio(40))
        
        flow.itemSize = cellSize
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 0;
        collectionView.collectionViewLayout = flow
        //        collectionView.backgroundColor = UIColor.yellow
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAmenitiesData(_ data : HomeExperience!, type : BookingDetailEnum!) {
        print(type)
        self.detailType = type
        switch detailType {
        case .none:
            self.appendUpcomingData(data)
            break
        case .upcomingExperience:
            self.appendUpcomingData(data)
            break
        case .nearMe:
            self.appendUpcomingData(data)
            break
        case .booking:
            break
        case .stories:
            break
        case .myExperience:
            break
        case .pastExperience:
            self.appendPastData(data)
            break
        
        default:
            print("")
        }
        
        
    }
    
    func appendUpcomingData(_ data : HomeExperience!) {
        arrAmenities.removeAll()
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_nameIcon", title: data.maestrosName!))
        arrAmenities.append(AmentiesCellData(image: "", title: ""))
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_locationIcon", title: data.location!))
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_priceIcon", title: "AED \(data.amount!)"))
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: data.experienceTypeName!))
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_TimeIcon", title: data.publishDate!))
    }
    func appendPastData(_ data : HomeExperience!) {
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_nameIcon", title: data.maestrosName!))
        arrAmenities.append(AmentiesCellData(image: "", title: ""))
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_locationIcon", title: data.location!))
       
        
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: "star", rating : data.rating!))//star
        arrAmenities.append(AmentiesCellData(image: "myExp_ExplorerIcon", title: data.location!))//explorers
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_TimeIcon", title: data.publishDate!))
        arrAmenities.append(AmentiesCellData(image: "myExp_CultureIcon", title: data.cultureName ?? "N/A"))
        arrAmenities.append(AmentiesCellData(image: "upcomingExp_typesOfExpIcon", title: data.experienceTypeName!))
        
    }
    
}

extension AmenitiesTableCell {
    
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        //        collectionView.contentOffset = CGPoint(x: 0, y:0)
        // collectionView.setContentOffset(CGPoint(x: 0, y:0), animated:false)
        // collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        //    self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
        //        collectionView.scrollsToTop = true
        collectionView.reloadData()
        //self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
        
        //        self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
        
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
