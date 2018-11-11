//
//  BookingDetailController.swift
//  Zaha
//
//  Created by muzamilhassan on 08/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class BookingDetailController: BaseViewController, StoryBoardHandler  {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.booking.rawValue, nil)
    @IBOutlet weak var tblBookingDetail: UITableView!
    var headerView : ParallaxHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        // Do any additional setup after loading the view.
    }
    
    func setUpTable() {
        
        tblBookingDetail.delegate = self
        tblBookingDetail.dataSource = self
        
        let parallaxViewFrame = CGRect(x: 0, y: 0, width: self.tblBookingDetail.bounds.width, height: DesignUtility.getValueFromRatio(HeaderHeight.mainHeaderHeight.rawValue))
        let homeView = HomeTopView.init(frame: parallaxViewFrame)
        homeView.setData(.BookingDetail)
        headerView  = ParallaxHeaderView.init(frame: parallaxViewFrame, view: homeView)
        tblBookingDetail.tableHeaderView  = headerView
        
        tblBookingDetail.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        tblBookingDetail.register(UINib(nibName: "HeaderTitleViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTitleViewCell")
        tblBookingDetail.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        tblBookingDetail.register(UINib(nibName: "PhotoCollectionTableCell", bundle: nil), forCellReuseIdentifier: "PhotoCollectionTableCell")
        
        
        
        tblBookingDetail.estimatedRowHeight = 200.0
        tblBookingDetail.rowHeight = UITableView.automaticDimension
        
        
        
       // tblBookingDetail.register(UINib.init(nibName: homeCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: homeCellReuseIdentifier)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tblBookingDetail.tableHeaderView as! ParallaxHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        //--ww  print("headerView" , headerView.frame)
        
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
extension BookingDetailController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return DesignUtility.getValueFromRatio(HeaderHeight.subTitleHeaderHeight.rawValue)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if (indexPath.row == 0) {
          return  DesignUtility.getValueFromRatio((self.view.frame.width - DesignUtility.getValueFromRatio(30))/3)
        }
        return UITableView.automaticDimension
//        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let  sectionCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTitleViewCell") as! HeaderTitleViewCell
        
        return sectionCell 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Description cell
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionTableCell", for: indexPath) as! PhotoCollectionTableCell
            
           // cell.setData(.bookingDetailDesc)
            //return cell
            cell.collectionView.tag = (100 * indexPath.section) + 1
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
           // cell.collectionViewOffset = storedOffsets[indexPath.section] ?? 0
            return cell;
        }
        else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            
            cell.setData(.bookingDetailDesc)
            return cell
        }
        
        return UITableViewCell()
        
        
        
        
    }

    
}


extension BookingDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGridCollectionCell", for: indexPath) as! PhotosGridCollectionCell
        return cell
        print("calling")
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

//extension BookingDetailController:UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        var cellSize:CGSize!
//
//        let width = (collectionView.bounds.width/3) //- 10
//        cellSize = CGSize(width: width, height: width)
//
//        return cellSize
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
//    }
//
//    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//
//
//
//}
