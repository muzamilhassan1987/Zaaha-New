//
//  PhotosGridCollectionCell.swift
//  Zaha
//
//  Created by muzamilhassan on 09/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class PhotosGridCollectionCell: UICollectionViewCell {

    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var imgPhoto: BaseUIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // let outerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: imgPhoto.frame.size.height))
//        imgPhoto.clipsToBounds = false
//        imgPhoto.layer.shadowColor = UIColor.black.cgColor
//        imgPhoto.layer.shadowOpacity = 1
//        imgPhoto.layer.shadowOffset = CGSize.zero
//        imgPhoto.layer.shadowRadius = 10
//        imgPhoto.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    func setPhoto(_ data : HomePicture) {
        
        btnVideo.isHidden = true
        imgPhoto.setImageFromUrl(urlStr: data.imageUrl!)
    }
    func setVideo(_ data : HomeVideo) {
        
        btnVideo.isHidden = false
        print(data.videoThumbUrl!)
        imgPhoto.setImageFromUrl(urlStr: data.videoThumbUrl!)
    }
    
    @IBAction func PlayVideo(_ sender: UIButton) {
        
    }

}
