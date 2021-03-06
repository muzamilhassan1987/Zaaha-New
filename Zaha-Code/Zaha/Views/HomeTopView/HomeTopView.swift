//
//  HomeTopView.swift
//

import UIKit

enum HeaderTypeEnum:Int {
    case viewProfile
    case BookingDetail
}

class HomeTopView: UIView {

    @IBOutlet weak var imgblur: BaseUIImageView!
    @IBOutlet weak var imgBg: BaseUIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblFirst: BaseUILabel!
    @IBOutlet weak var lblSecond: BaseUILabel!
    var isAnimating = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        commomInit()
    }
    
    
    
    func commomInit(){
        Bundle.main.loadNibNamed("HomeTopView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
       // self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
//       lblFirst.text = GlobalStatic.getLocalizedString("laundry_problem")
//      lblSecond.text = GlobalStatic.getLocalizedString("we_can")
       
        ParallaxHeaderView.delegateScroll = self
    }

    func setData(_ type : HeaderTypeEnum, data : Any? = nil) {
        
        
        
        imgblur.isHidden = true
        switch type {
        case .BookingDetail:
            imgLogo.isHidden = true
            self.setDetail(data: data)
            break
        case .viewProfile:
            let user = data as! UserData
            
            imgLogo.setImageFromUrl(urlStr: user.imageUrl!)
            imgBg.setImageFromUrl(urlStr: user.imageUrl!)
            imgLogo.isHidden = false
            break
        default:
            print("")
        }
    }
    
    func setDetail(data : Any?) {
        
        if let objExperience = data as? HomeExperience {
            imgBg.setImageFromUrl(urlStr: objExperience.imageUrl!)
        }
        if let objStory = data as? HomeStory {
            //imgBg.setImageFromUrl(urlStr: objStory//.imageUrl!)
        }
    }
    
 
}
extension HomeTopView : UpdateFrameDelegate {
    func updateFrame()  {
//        let height = DesignUtility.getValueFromRatio(257) * 0.33
//
//        if self.imgLogo.frame.height > height {
//
//            if isAnimating == false{
//                isAnimating = true
//                self.imgLogo.layer.speed = 1
//                if !self.imgLogo.isAnimating{
//                    self.imgLogo.rotate()
//                }
//            }
//            let txt = GlobalStatic.getLocalizedString("we_can")
////            if self.lblSecond.text == txt {
////                self.lblSecond.animate(newText: txt, characterDelay: 0.1)
////            }
//        }else{
//
//            if isAnimating == true {
//                isAnimating = false
//                self.imgLogo.stopAnimationAndFinish()
//            }
//        }
    }
}
