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
        self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
        
        //        self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
        
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
