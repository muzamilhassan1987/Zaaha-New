//
//  ViewProfileController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/9/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum profileCellEnum : Int {
    case rating
    case list
}


class ViewProfileController: BaseViewController, StoryBoardHandler {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.booking.rawValue, nil)
    @IBOutlet weak var tblProfileView: UITableView!
    var headerView : ParallaxHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()
        // Do any additional setup after loading the view.
    }
    func setUpTable() {
        
        tblProfileView.delegate = self
        tblProfileView.dataSource = self
        
        let headerViewFrame = CGRect(x: 0, y: 0, width: self.tblProfileView.bounds.width, height: DesignUtility.getValueFromRatio(HeaderHeight.mainHeaderHeight.rawValue))
        let homeView = HomeTopView.init(frame: headerViewFrame)
        headerView  = ParallaxHeaderView.init(frame: headerViewFrame, view: homeView)
        tblProfileView.tableHeaderView  = headerView
        
//        tblBookingDetail.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
//        tblBookingDetail.register(UINib(nibName: "HeaderTitleViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTitleViewCell")
//        tblBookingDetail.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        tblProfileView.estimatedRowHeight = 200.0
        tblProfileView.rowHeight = UITableView.automaticDimension
        
        tblProfileView.register(UINib(nibName: "HeaderTitleViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTitleViewCell")
        tblProfileView.register(UINib(nibName: "ProfileInfoCell", bundle: nil), forCellReuseIdentifier: "ProfileInfoCell")
        tblProfileView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        
        // tblBookingDetail.register(UINib.init(nibName: homeCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: homeCellReuseIdentifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ViewProfileController : UITableViewDataSource, UITableViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tblProfileView.tableHeaderView as! ParallaxHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        //--ww  print("headerView" , headerView.frame)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return DesignUtility.getValueFromRatio(HeaderHeight.subTitleHeaderHeight.rawValue)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let  sectionCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTitleViewCell") as! HeaderTitleViewCell
        sectionCell.setData(HeaderTitleTypeEnum.viewProfile)
        return sectionCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        switch indexPath.row
//        {
//        case BookingDetailCellEnum.description.rawValue:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell
//
//            cell.lblDescription.isHidden = false
//            cell.lblDescription.text = "Description"
//            // cell.lblDescriptionContent.text = dataArray?.adDescription!
//
//        default:
//            return UITableViewCell()
//        }
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell
            cell.selectionStyle = .none
            return cell
        }
        else if (indexPath.row > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
            cell.setData(.viewProfile)
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
        
        
        
        
    }
    
    
}
