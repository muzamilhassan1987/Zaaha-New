//
//  BookingCell.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/7/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var imgMain: BaseUIImageView!
    @IBOutlet weak var lblDateTime: BaseUILabel!
    @IBOutlet weak var lblMaestro: BaseUILabel!
    @IBOutlet weak var lblTitle: BaseUILabel!
    @IBOutlet weak var btnView: BaseUIButton!
    @IBOutlet weak var btnStatus: BaseUIButton!
    var experience : HomeExperience?
    var story : HomeStory?
    var userRole = UserRole.explorer
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
    
    func setData(_ data : BaseHomeModel) {
        
        
//        viewTwoLabel.isHidden = true
//        viewFiveLabels.isHidden = true
//        webView.isHidden = true
//
        userRole = UserRole(rawValue: CurrentUser.data!.userRole!)!
    
        if let objExperience = data as? HomeExperience {
            experience = objExperience
            lblTitle.text = experience?.title!
            lblMaestro.text = experience?.maestrosName!
            lblDateTime.text = experience?.publishDate!
            
//            lblTitle.text = "Lunch at Beach!"
//            lblMaestro.text = "Maestro: Saida Ahmed Imam"
//            lblDateTime.text = "Date/Time: Sat 9th Dec / 0800HRS"
            imgMain.setImageFromUrl(urlStr: experience!.imageUrl!)
            setBookingStatus()
            if(userRole == .explorer){
                btnStatus.isUserInteractionEnabled = false
                
            }
            else if(userRole == .maestro){
                btnStatus.isUserInteractionEnabled = true
                
            }
        }
        if let objStory = data as? HomeStory {
            story = objStory
            
        }
        
        
        
//        switch self.type {
//        case .viewProfile:
//            viewTwoLabel.isHidden = false
//            imgVideoIcon.isHidden = true
//            layoutTopPadding.constant = 20.0
//            break
//        case .stories:
//            viewTwoLabel.isHidden = false
//            imgVideoIcon.isHidden = false
//            layoutTopPadding.constant = 20.0
//            //imgMain.setImageFromUrl(urlStr: story!.imageUrl!)
//            lblStoryTitle.text = story?.title!
//            lblStoryTitle.text = "AED \(String(describing: story!.title!))"
//            lblStoryDateTime.text = "Date/Time: \(String(describing: story!.createdAt!))"
//            break
//        case .homeList:
//            viewFiveLabels.isHidden = false
//            imgVideoIcon.isHidden = true
//            imgMain.setImageFromUrl(urlStr: experience!.imageUrl!)
//            lblExpTitle.text = experience?.title!
//            lblPrice.text = "AED \(String(describing: experience!.amount!))"
//            lblMaestro.text = "Maestro \(String(describing: experience!.maestrosName!))"
//            lblDateTime.text = "Date/Time: \(String(describing: experience!.publishDate!))"
//            //            lblCategory.text = "Date/Time: \(String(describing: experience!.!))"
//            break
//        default:
//            print("")
//        }
    }
    
    
    func setBookingStatus() {
        
        let status = BookingStatus(rawValue: (experience?.bookingStatus!)!)!
    
        print(status)
        print(experience?.bookingStatus)
        btnStatus.setTitle("", for: .normal)
        switch status {
        case .Available:
//            btnStatus.backgroundColor = Color.BookStatus.
            btnStatus.backgroundColor = Color.BookStatus.pending
            btnStatus.setTitle("Pending", for: .normal)
            break
        case .Cancel:
            btnStatus.backgroundColor = Color.BookStatus.rejected
            btnStatus.setTitle("Rejected", for: .normal)
            break
        case .Pending:
            btnStatus.backgroundColor = Color.BookStatus.pending
            btnStatus.setTitle("Pending", for: .normal)
            break
        case .Completed:
            btnStatus.backgroundColor = Color.BookStatus.confirmed
            btnStatus.setTitle("Confirmed", for: .normal)
            break
        case .Rejected:
            btnStatus.backgroundColor = Color.BookStatus.rejected
            btnStatus.setTitle("Rejected", for: .normal)
            break
        default:
            break
            print("")
        }
        
    }
}
