//
//  PhotosListCollectionCell.swift
//  Zaha
//
//  Created by muzamilhassan on 09/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class PhotosListCollectionCell: UICollectionViewCell {

    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var imgPhoto: BaseUIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        imgPhoto.setImageFromUrl(urlStr: data.videoThumbUrl!)
    }

    @IBAction func PlayVideo(_ sender: UIButton) {
        
    }
}
