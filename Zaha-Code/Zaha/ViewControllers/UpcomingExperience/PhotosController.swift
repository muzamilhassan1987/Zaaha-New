//
//  PhotosController.swift
//  Zaha
//
//  Created by muzamilhassan on 09/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class PhotosController: BaseViewController , StoryBoardHandler {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.upcommingExperience.rawValue , nil)
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var tblListing: UITableView!
    var cellType:String = "Grid"
    @IBOutlet var btnGrid: UIButton!
    @IBOutlet var btnList: UIButton!
    var arrPhotos : [HomePicture]? = nil
    var arrVideos : [HomeVideo]? = nil
    var detailType = BookingDetailEnum.none
    override func viewDidLoad() {
        super.viewDidLoad()

        registeredNibs()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseNavigation?.createBackButton()
    }
    
    func registeredNibs(){
        
        
        collectionView.register(UINib(nibName: "PhotosGridCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotosGridCollectionCell")
        collectionView.register(UINib(nibName: "PhotosListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotosListCollectionCell")
//        let cellRow = UINib(nibName: "LoadMoreCollectionFooter", bundle: nil)
//        self.collectionView.register(cellRow, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "LoadMoreCollectionFooter")
    }
    @IBAction func btnGridTapped(_ sender: UIButton){
        
        self.cellType = "Grid"
        self.btnGrid.setImage(UIImage(named: "photos_SectionedSelectedIcon"), for: .normal)
        self.btnList.setImage(UIImage(named: "photos_SingleIcon"), for: .normal)
        UIView.transition(with: self.collectionView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.collectionView.layoutIfNeeded()
            self.collectionView.reloadData()
        }, completion: nil)
    }
    @IBAction func btnListTapped(_ sender: UIButton){
        
        self.cellType = "List"
        self.btnGrid.setImage(UIImage(named: "photos_SectionedIcon"), for: .normal)
        self.btnList.setImage(UIImage(named: "photos_SingleSelectedIcon"), for: .normal)
        UIView.transition(with: self.collectionView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.collectionView.layoutIfNeeded()
            self.collectionView.reloadData()
        }, completion: nil)
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

extension PhotosController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if let photos = self.arrPhotos {
            return photos.count
        }
        if let videos = self.arrVideos {
            return videos.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if(cellType == "Grid"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGridCollectionCell", for: indexPath) as! PhotosGridCollectionCell
            if let photos = self.arrPhotos {
                cell.setPhoto(photos[indexPath.row])
            }
            if let videos = self.arrVideos {
                cell.setVideo(videos[indexPath.row])
            }
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosListCollectionCell", for: indexPath) as! PhotosListCollectionCell
            if let photos = self.arrPhotos {
                cell.setPhoto(photos[indexPath.row])
            }
            if let videos = self.arrVideos {
                cell.setVideo(videos[indexPath.row])
            }
            return cell
        }
    }
    

    
}
extension PhotosController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        var cellSize:CGSize!
        
        if(cellType == "Grid"){
            let width = (collectionView.bounds.width/3)-10
            cellSize = CGSize(width: width, height: width)
        }
        else{
            let width = (collectionView.bounds.width)-10
            cellSize = CGSize(width: width, height: DesignUtility.getValueFromRatio(width - 100))
        }
        
        return cellSize
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
//        return CGSize(width: self.view.frame.width, height: 100.0)
//
//    }
    
}
extension PhotosController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        self.view.endEditing(true)
//        
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AdDetailController_ID") as! AdDetailController
//        VC.adID = self.homeData[indexPath.row].id!
//        VC.categoryName = self.homeData[indexPath.row].catName!
//        VC.subCategoryName = self.homeData[indexPath.row].subCatName!
//        self.navigationController?.pushViewController(VC, animated: true)
        
    }
}
