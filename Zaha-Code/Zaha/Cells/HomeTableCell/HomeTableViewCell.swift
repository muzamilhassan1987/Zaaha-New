//
//  HomeTableViewCell.swift
//  Zaha
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum HomeTableViewType : Int {
    case none
    case viewProfile
    case homeList
    case stories
}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imgVideoIcon: UIImageView!
    
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblStoryDateTime: UILabel!
    @IBOutlet weak var lblStoryTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblMaestro: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblExpTitle: UILabel!
    @IBOutlet weak var layoutTopPadding: NSLayoutConstraint!
    @IBOutlet weak var viewFiveLabels: UIView!
    @IBOutlet weak var viewTwoLabel: UIView!
    var type = HomeTableViewType.none
    var experience : HomeExperience?
    var story : HomeStory?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ type : HomeTableViewType? = nil, data : BaseHomeModel) {
        
        
        viewTwoLabel.isHidden = true
        viewFiveLabels.isHidden = true
        
        
        if let objExperience = data as? HomeExperience {
            self.type = .homeList
            experience = objExperience
        }
        if let objStory = data as? HomeStory {
            self.type = .stories
            story = objStory
            
        }
        
        switch self.type {
        case .viewProfile:
            viewTwoLabel.isHidden = false
            imgVideoIcon.isHidden = true
            layoutTopPadding.constant = 20.0
            break
        case .stories:
            viewTwoLabel.isHidden = false
            imgVideoIcon.isHidden = false
            layoutTopPadding.constant = 20.0
            //imgMain.setImageFromUrl(urlStr: story!.imageUrl!)
            lblStoryTitle.text = story?.title!
            lblStoryTitle.text = "AED \(String(describing: story!.title!))"
            lblStoryDateTime.text = "Date/Time: \(String(describing: story!.createdAt!))"
            break
        case .homeList:
            viewFiveLabels.isHidden = false
            imgVideoIcon.isHidden = true
            imgMain.setImageFromUrl(urlStr: experience!.imageUrl!)
            lblExpTitle.text = experience?.title!
            lblPrice.text = "AED \(String(describing: experience!.amount!))"
            lblMaestro.text = "Maestro \(String(describing: experience!.maestrosName!))"
            lblDateTime.text = "Date/Time: \(String(describing: experience!.publishDate!))"
//            lblCategory.text = "Date/Time: \(String(describing: experience!.!))"
            break
        default:
            print("")
        }
    }
    
    
    
}
