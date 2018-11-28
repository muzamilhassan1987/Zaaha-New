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
    var manager = DetailPostManager()
    var detailData : Any? = nil
    var experienceData : HomeExperience?
    var arrAmenities = [AmentiesCellData]()
    var arrPhotos = [HomePicture]()
    var arrVideos = [HomeVideo]()
    var arrStories = [HomeStory]()
    var isDataLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let objExperience = detailData as? HomeExperience {
            self.experienceData = objExperience
        }
        if let objStory = detailData as? HomeStory {
        }
        
//        setInitialData()
        setUpTable()
        print("------------------------------------")
        print(detailType)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseNavigation?.createBackButton()
    }
    
    func setUpTable() {
        
        tblBookingDetail.delegate = nil
        tblBookingDetail.dataSource = nil
        
        
        
        tblBookingDetail.register(UINib(nibName: "HeaderTitleViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTitleViewCell")
        
        
        tblBookingDetail.estimatedRowHeight = 200.0
        tblBookingDetail.rowHeight = UITableView.automaticDimension
        
        
        
       // tblBookingDetail.register(UINib.init(nibName: homeCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: homeCellReuseIdentifier)
    }
    func setUpTableData() {
        tblBookingDetail.delegate = self
        tblBookingDetail.dataSource = self
        let parallaxViewFrame = CGRect(x: 0, y: 0, width: self.tblBookingDetail.bounds.width, height: DesignUtility.getValueFromRatio(HeaderHeight.mainHeaderHeight.rawValue))
        let homeView = HomeTopView.init(frame: parallaxViewFrame)
        //homeView.setData(.BookingDetail)
        homeView.setData(.BookingDetail, data: experienceData!)
        headerView  = ParallaxHeaderView.init(frame: parallaxViewFrame, view: homeView)
        tblBookingDetail.tableHeaderView  = headerView
    }
    func setInitialData() {
        
        
        self.arrPhotos = experienceData!.pictures!
        self.arrVideos = experienceData!.videos!
        self.arrStories = experienceData!.stories!
        switch detailType {
        case .none:
            fetchPtlist("UpComingExperience")
            tempCollectionCount = 6
            tempDetailCollection = AmenitiesCollectionCell.upcomingDetailData
            break
        case .upcomingExperience:
            baseNavigation?.lblTitle.text = "Upcoming Experiences".uppercased()
            fetchPtlist("UpComingExperience")
            tempCollectionCount = 6
            tempDetailCollection = AmenitiesCollectionCell.upcomingDetailData
            
            break
        case .booking:
            baseNavigation?.lblTitle.text = "Booking".uppercased()
            tempDetailCollection = AmenitiesCollectionCell.bookingDetailData
            break
        case .stories:
            baseNavigation?.lblTitle.text = "Stories".uppercased()
            break
        case .myExperience:
            baseNavigation?.lblTitle.text = "My Experiences".uppercased()
            fetchPtlist("MyExperience")
            tempCollectionCount = 8
            tempDetailCollection = AmenitiesCollectionCell.pastExpDetailData
            break
        case .pastExperience:
            baseNavigation?.lblTitle.text = "Past Experiences".uppercased()
            fetchPtlist("PastExperience")
            filterDataArray("videos")
            filterDataArray("pictures")
            tempCollectionCount = 8
            tempDetailCollection = AmenitiesCollectionCell.pastExpDetailData
            break
        default:
            print("")
        }
        
        
        tblBookingDetail.reloadData()
        
    }

    func filterDataArray(_ type : String) {
        
        
        let k = dataArray! as Array
//        var selectedIndex = 0
        let index = k.index {
            if let dic = $0 as? Dictionary<String,AnyObject> {
                
                if let value = dic["type"]  as? String, value == type{
                    return true
                }
            }
            return false
        }
        if (type == "videos") {
            if self.arrVideos.count <= 0 {
                if let ind = index {
                    dataArray?.removeObject(at: ind)
                    dataArray?.removeObject(at: ind - 1)
                }
            }
        }
        else if (type == "pictures") {
            if self.arrPhotos.count <= 0 {
                if let ind = index {
                    dataArray?.removeObject(at: ind)
                    dataArray?.removeObject(at: ind-1)
                }
            }
        }
        
    
        //let index = dataArray!.index(where: {$0["type"] == "5mbps"})
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(isDataLoaded == false) {
            getDetailServer()
        }
        
        
    }

    
    
    func fetchPtlist(_ plist : String) {
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            dataArray = NSMutableArray(contentsOfFile: path);
            //
            
            tblBookingDetail.register(UINib.init(nibName: "BookingStatusCell", bundle: nil), forCellReuseIdentifier: "BookingStatusCell")
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
        sectionCell.setData(.experienceDetail, data: experienceData!)
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
            cell.setAmenitiesData(experienceData!, type: detailType)
            self.arrAmenities.removeAll()
            self.arrAmenities = cell.arrAmenities
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            setCellProperties(cell)
            return cell;
            
        case cellIdentifiers.description.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! DescriptionCell
                setCellProperties(cell)
                cell.setData(experienceData!, type: detailType)
                return cell
        case cellIdentifiers.buttons.rawValue:
            if (detailType == .none || detailType == .upcomingExperience) {
                if(experienceData?.bookingStatus! == BookingStatus.Available.rawValue) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! ButtonsCell
                    cell.buttonCellDelegate = self
                    setCellProperties(cell)
                    cell.setData(detailType)
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BookingStatusCell", for: indexPath) as! BookingStatusCell
                    //cell.buttonCellDelegate = self
                    setCellProperties(cell)
                    cell.setData(experienceData!, type: detailType)
                    return cell
                }
                
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath) as! ButtonsCell
                cell.buttonCellDelegate = self
                setCellProperties(cell)
                cell.setData(detailType)
                return cell
            }
            
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
            
            
            //dict?["type"] as? String/
            cell.collectionView.accessibilityHint = cellIdentifiers.photoVideoCell.rawValue
            cell.collectionView.accessibilityValue = dict?["type"] as? String
            print(cell.collectionView.accessibilityHint!)
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            setCellProperties(cell)
            
//            if (cell.collectionView.accessibilityHint! == "videos"){
//                cell.setMediaData(<#T##data: HomeExperience!##HomeExperience!#>, type: <#T##BookingDetailEnum!#>)
//            }
//            else if (cell.collectionView.accessibilityHint! == "pictures"){
//
//            }
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            setCellProperties(cell)
            //cell.setAmenitiesData(experienceData!, type: detailType)
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
            return self.arrAmenities.count
            //return tempDetailCollection.count
        case cellIdentifiers.photoVideoCell.rawValue:
            if (collectionView.accessibilityValue! == "videos"){
                return arrVideos.count >= 3 ? 3 : arrVideos.count
            }
            else if (collectionView.accessibilityValue! == "pictures"){
                return arrPhotos.count >= 3 ? 3 : arrPhotos.count
            }
            print(arrPhotos.count >= 3 ? 3 : arrPhotos.count)
            return 0// arrPhotos.count >= 3 ? 3 : arrPhotos.count
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
            cell.setData(self.arrAmenities[indexPath.row])
            //cell.setda
            return cell
        case cellIdentifiers.photoVideoCell.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGridCollectionCell", for: indexPath) as! PhotosGridCollectionCell
            print(self.arrPhotos.count)
            print(self.arrVideos.count)
            if (collectionView.accessibilityValue! == "videos"){
                cell.setVideo(self.arrVideos[indexPath.row])
            }
            else if (collectionView.accessibilityValue! == "pictures"){
                cell.setPhoto(self.arrPhotos[indexPath.row])
            }
            
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
    func viewAllClick(_ type: ViewAllEnum) {
        if (type == .photo){
            router.goToUpPhotosController(from: self, type: detailType, videos: nil, photos: self.arrPhotos)
        }
        else if (type == .photo){
            router.goToUpPhotosController(from: self, type: detailType, videos: self.arrVideos, photos: nil)
        }
        
    }
}


extension BookingDetailController{
    
    func getDetailServer() {
        
//        var parameters = [String : String]()
//       parameters.updateValue("\(String(describing: self.experienceData!.id!))", forKey: "experience_id")
        var parameters = [String : String]()
        
        
        parameters.updateValue("1", forKey: "experience_id")
        //parameters.updateValue(String(experienceData!.id!), forKey: "experience_id")
        print(parameters)
        let requestParam =  self.manager.paramsDetail(parameters as [String : AnyObject], type: detailType)
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                print(self.manager.data)
                self.isDataLoaded = true
                self.detailData = self.manager.experienceData!
                self.experienceData! = self.manager.experienceData!
                self.setInitialData()
                self.setUpTableData()

            }
        })
    }
    
    
}
