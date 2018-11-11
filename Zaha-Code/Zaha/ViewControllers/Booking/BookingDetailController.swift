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
    var dataArray:NSMutableArray?
    var headerView : ParallaxHeaderView!
    var detailType = BookingDetailEnum.none
    var tempCollectionCount = 0
    var tempDetailCollection = AmenitiesCollectionCell.bookingDetailData
//    var cellPreData = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialData()
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
        
//        tblBookingDetail.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
        tblBookingDetail.register(UINib(nibName: "HeaderTitleViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTitleViewCell")
//        tblBookingDetail.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
//        tblBookingDetail.register(UINib(nibName: "PhotoCollectionTableCell", bundle: nil), forCellReuseIdentifier: "PhotoCollectionTableCell")
//        tblBookingDetail.register(UINib(nibName: "AmenitiesTableCell", bundle: nil), forCellReuseIdentifier: "AmenitiesTableCell")
//        tblBookingDetail.register(UINib(nibName: "ButtonsCell", bundle: nil), forCellReuseIdentifier: "ButtonsCell")
        
        
        
        tblBookingDetail.estimatedRowHeight = 200.0
        tblBookingDetail.rowHeight = UITableView.automaticDimension
        
        
        
       // tblBookingDetail.register(UINib.init(nibName: homeCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: homeCellReuseIdentifier)
    }
    
    func setInitialData() {
        
        switch detailType {
        case .none:
            self.title = "Home".uppercased()
            fetchPtlist("UpComingExperience")
            tempCollectionCount = 6
            tempDetailCollection = AmenitiesCollectionCell.upcomingDetailData
            break
        case .upcomingExperience:
            self.title = "Upcoming Experiences".uppercased()
            fetchPtlist("UpComingExperience")
            tempDetailCollection = AmenitiesCollectionCell.upcomingDetailData
            
            break
        case .booking:
            self.title = "Booking".uppercased()
            tempDetailCollection = AmenitiesCollectionCell.bookingDetailData
            break
        case .stories:
            self.title = "Stories".uppercased()
            break
        case .myExperience:
            self.title = "My Experiences".uppercased()
            fetchPtlist("MyExperience")
            tempDetailCollection = AmenitiesCollectionCell.pastExpDetailData
            break
        case .pastExperience:
            self.title = "Past Experiences".uppercased()
            fetchPtlist("PastExperience")
            tempDetailCollection = AmenitiesCollectionCell.pastExpDetailData
            break
        default:
            print("")
        }
        
        
    }

    func fetchPtlist(_ plist : String) {
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            dataArray = NSMutableArray(contentsOfFile: path);
            //
            for data:NSMutableDictionary in (dataArray as? [NSMutableDictionary])! {
                if let cellId:String = data["cellIdentifier"] as? String {
                    tblBookingDetail.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
                }
            }
            
        }
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
    
    
    func setCellProperties(_ cell : UITableViewCell) {
        cell.isExclusiveTouch = true;
        cell.contentView.isExclusiveTouch = true;
        cell.selectionStyle = .none
        for obj in cell.subviews {
            if NSStringFromClass(type(of: obj)) == "UITableViewCellScrollView" {
                let scroll: UIScrollView = (obj as? UIScrollView)!
                scroll.delaysContentTouches = false
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return DesignUtility.getValueFromRatio(HeaderHeight.subTitleHeaderHeight.rawValue)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        
        let dict = dataArray?[indexPath.row] as? NSMutableDictionary
        let identifier = dict?["cellIdentifier"] as? String
        switch identifier {
        case cellIdentifiers.amenities.rawValue:
            var row = CGFloat((tempDetailCollection.count/2))
            return DesignUtility.getValueFromRatio(40*row) + 10
        case cellIdentifiers.description.rawValue:
            return UITableView.automaticDimension
        case cellIdentifiers.buttons.rawValue:
            return DesignUtility.getValueFromRatio(80)
        case cellIdentifiers.viewAll.rawValue:
            return DesignUtility.getValueFromRatio(50)
        case cellIdentifiers.photoVideoCell.rawValue:
            return DesignUtility.getValueFromRatio((self.view.frame.width - DesignUtility.getValueFromRatio(30))/3)
        default:
            print("")
        }
        
        if (indexPath.row == 0) {
            return DesignUtility.getValueFromRatio(40*2) + 10
          //return  DesignUtility.getValueFromRatio((self.view.frame.width - DesignUtility.getValueFromRatio(30))/2)
        }
        if (indexPath.row == 2) {
            return DesignUtility.getValueFromRatio(60)
            //return  DesignUtility.getValueFromRatio((self.view.frame.width - DesignUtility.getValueFromRatio(30))/2)
        }
//        if (indexPath.row == 0) {
//            return  DesignUtility.getValueFromRatio((self.view.frame.width - DesignUtility.getValueFromRatio(30))/3)
//        }
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
        return dataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = dataArray?[indexPath.row] as? NSMutableDictionary
        let identifier = dict?["cellIdentifier"] as? String
        
       
        switch identifier {
        case cellIdentifiers.amenities.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! AmenitiesTableCell
            cell.collectionView.tag = indexPath.row//(100 * indexPath.section) + 1
            cell.collectionView.accessibilityHint = cellIdentifiers.amenities.rawValue
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            setCellProperties(cell)
            return cell;
            
        case cellIdentifiers.description.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! DescriptionCell
                setCellProperties(cell)
                cell.setData(detailType)
                return cell
        case cellIdentifiers.buttons.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! ButtonsCell
            cell.buttonCellDelegate = self
            setCellProperties(cell)
            cell.setData(detailType)
            return cell
        case cellIdentifiers.viewAll.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! ViewAllCell
            cell.viewAllCellDelegate = self
            setCellProperties(cell)
            cell.setData(dict ?? NSMutableDictionary())
//            cell.setData(ViewAllEnum)
//            cell.setData(detailType)
            return cell
        case cellIdentifiers.photoVideoCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! PhotoCollectionTableCell
            cell.collectionView.tag = indexPath.row//(100 * indexPath.section) + 1
            cell.collectionView.accessibilityHint = cellIdentifiers.photoVideoCell.rawValue
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            setCellProperties(cell)
            return cell;
            
        default:
            print("")
        }
        
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesTableCell", for: indexPath) as! AmenitiesTableCell
            cell.collectionView.tag = indexPath.row//(100 * indexPath.section) + 1
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
//            self.view.layoutSubviews()
//            self.view.layoutIfNeeded()
            return cell;
        }
        //Description cell
        if (indexPath.row == 10) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionTableCell", for: indexPath) as! PhotoCollectionTableCell
            cell.collectionView.tag = (100 * indexPath.section) + 1
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            return cell;
        }
        else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            
            //cell.setData(.bookingDetailDesc)
            return cell
        }
        else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsCell", for: indexPath) as! ButtonsCell
        
//            cell.setData(.bookingDetailDesc)
            return cell
        }
        
        return UITableViewCell()
        
        
        
        
    }

    
}


extension BookingDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.accessibilityHint {
        case cellIdentifiers.amenities.rawValue:
            return tempDetailCollection.count
        case cellIdentifiers.photoVideoCell.rawValue:
            return 3
        default:
            print("")
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGridCollectionCell", for: indexPath) as! PhotosGridCollectionCell
        
        print("calling")
        
        
        switch collectionView.accessibilityHint {
        case cellIdentifiers.amenities.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCollectionCell", for: indexPath) as! AmenitiesCollectionCell
            cell.setData(tempDetailCollection[indexPath.row])
            return cell
        case cellIdentifiers.photoVideoCell.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGridCollectionCell", for: indexPath) as! PhotosGridCollectionCell
           // cell.setData(tempDetailCollection[indexPath.row])
            return cell
        default:
            print("")
        }
        
        
        return UICollectionViewCell()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

//extension BookingDetailController:UICollectionViewDelegateFlowLayout{
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////        var cellSize:CGSize!
////
////        let width = (collectionView.bounds.width/3) //- 10
////        cellSize = CGSize(width: width, height: width)
////
////        return cellSize
////    }
//
//
////
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
//    }
//
////    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
////        return true
////    }
////
////
////
//}
extension BookingDetailController: ButtonTableCellDelegate
{

    func bookExperience() {
        let controller = BookSpecialController.loadVC()
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true) {
            
        }
        
    }
}

extension BookingDetailController: ViewAllCellDelegate
{
    
    func viewAllClick() {
        //let controller = PhotosController.loadVC()
        router.goToUpPhotosController(from: self)
//        controller.modalPresentationStyle = .overCurrentContext
//        controller.modalTransitionStyle = .crossDissolve
//        self.present(controller, animated: true) {
//
//        }
        
    }
}
