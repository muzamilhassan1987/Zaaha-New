
//
//  CreateStoryController.swift
//  Zaha
//
//  Created by Faraz Haider on 24/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import Tags
import MobileCoreServices
import AVKit
import AVFoundation

class CreateStoryController: BaseViewController , StoryBoardHandler {
    @IBOutlet weak var storyTitleLabel: BaseUITextField!
    @IBOutlet weak var uploadVideoLabel: UILabel!
    @IBOutlet weak var videoThumbImageView: UIImageView!
    @IBOutlet private weak var tagsView: TagsView!
    @IBOutlet private weak var tagsLabel: UILabel!
    private var alertController: UIAlertController?
    var imagePickerController = UIImagePickerController()

    var params = [String : String?]()
    var createExpManager = ExperienceManager()
    var experienceListArray = [String]()
     var experienceModelArray = [MyExperienceExperiences]()
    @IBOutlet weak var experienceTxtField: BaseUITextField!
   
    var experienceId:Int?
    var videoData : NSData?
    
    @IBAction func selectExperienceButtonClicked(_ sender: Any) {
        addPickerForExperienceList()
    }
    
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.upcommingExperience.rawValue , nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
       // setNavBar()
        getExperienceList()
        self.tagsView.delegate = self
        self.tagsLabel.numberOfLines = 0
        
        self.makeTagsString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if let btnBack = baseNavigation?.btnBack {
        //            btnBack.removeFromSuperview()
        //        }
        baseNavigation?.lblTitle.text = "CREATE STORY"
        baseNavigation?.createBackButton()
    }
    
    private func makeTagsString() {
        self.tagsLabel.text = self.tagsView.tagTextArray
            .reduce("tags:\n", { (result, str) -> String in
                return "\(result)\(str),"
            })
    }
    
    func setNavBar()
    {
        self.title = "CREATE STORY"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func browseVideoButtonClicked(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
        imagePickerController.videoMaximumDuration = 1
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func addStoryButtonClicked(_ sender: Any) {
        print(tagsLabel.text)
        
        let isValid = checkValidationForCreateExp()
        
        if isValid{
            params = ["experience_id" : "\(experienceId!)" as? String,
                      "title":storyTitleLabel.text!,
                      "tags":tagsLabel.text!
            ]
            
            let requestParam = self.createExpManager.paramsCreateStory(parameters: params as [String : AnyObject])
            
            self.createExpManager.creteStoryApiWithVideo(requestParam,videoData: videoData! as Data, completion: {
                
                if self.createExpManager.isSuccess {
                    Alert.showWithCompletion(msg: self.createExpManager.message, completionAction: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    
                    print("failed")
                }
            })
        }else{
            Alert.showMsg(msg: "Please fill all the field to create Story")
        }
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.title = "Choose Video"
    }
    
    
    
    
    
}


extension CreateStoryController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        guard info[UIImagePickerController.InfoKey.mediaType] != nil else { return }
        
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
            
            let data = NSData(contentsOf: videoUrl as URL)!
            videoData = data
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            
            videoThumbImageView.image = previewImageFromVideo(url: videoUrl as NSURL)!
            videoThumbImageView.contentMode = .scaleAspectFit
            
        }
        else{
            print("Something went wrong in  video")
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    
    func previewImageFromVideo(url:NSURL) -> UIImage? {
        let asset = AVAsset(url:url as URL)
        let imageGenerator = AVAssetImageGenerator(asset:asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        var time = asset.duration
        time.value = min(time.value,2)
        
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            return nil
        }
    }
}


extension CreateStoryController: TagsDelegate{
    // MARK: TagsDelegate
    
    /// Last Tag Touch Action
    func tagsLastTagAction(_ tagsView: TagsView, tagButton: TagButton) {
        let alertController = UIAlertController(title: nil, message: "Append Tag", preferredStyle: .alert)
        self.alertController = alertController
        alertController.addTextField(configurationHandler: { (textField) in
            textField.returnKeyType = .next
            textField.delegate = self
            textField.becomeFirstResponder()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Append", style: .default, handler: { (_) in
            if let textArray = alertController.textFields?.compactMap({ $0.text }).filter({ $0 != ""}) {
                /// append
                self.tagsView.append(contentsOf: textArray)
                self.makeTagsString()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    /// Tag Touch Action
    func tagsTouchAction(_ tagsView: TagsView, tagButton: TagButton) {
        /// Update & Delete ActionSheet UIAlertController
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
            
            /// Update UIAlertController
            let alertController = UIAlertController(title: nil, message: "Update Tag", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.text = tagButton.currentTitle
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
                guard let text = alertController.textFields?.first?.text, text.count != 0 else {
                    return
                }
                /// Update
                tagsView.update(text, at: tagButton.index)
                self.makeTagsString()
            }))
            self.present(alertController, animated: true, completion: nil)
            
        }))
        
        
        alertController.addAction(UIAlertAction(title: "PrevInsert", style: .default, handler: { (_) in
            /// Prev Insert UIAlertController
            let alertController = UIAlertController(title: nil, message: "Prev Insert Tag", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Insert", style: .default, handler: { (_) in
                guard let text = alertController.textFields?.first?.text, text.count != 0 else {
                    return
                }
                /// Insert
                tagsView.insert(text, at: tagButton.index)
                self.makeTagsString()
            }))
            self.present(alertController, animated: true, completion: nil)
        }))
        
        
        alertController.addAction(UIAlertAction(title: "NextInsert", style: .default, handler: { (_) in
            /// Next Insert UIAlertController
            let alertController = UIAlertController(title: nil, message: "Next Insert Tag", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Insert", style: .default, handler: { (_) in
                guard let text = alertController.textFields?.first?.text, text.count != 0 else {
                    return
                }
                /// Insert
                tagsView.insert(text, at: tagButton.index + 1)
                self.makeTagsString()
            }))
            self.present(alertController, animated: true, completion: nil)
        }))
        
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            /// Remove
            tagsView.remove(tagButton)
            self.makeTagsString()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}



extension CreateStoryController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let alertController = self.alertController {
            alertController.addTextField(configurationHandler: { (textField) in
                textField.returnKeyType = .next
                textField.delegate = self
                textField.becomeFirstResponder()
            })
        }
        return false
    }
}


extension CreateStoryController{
    
    func getExperienceList() {
        var parameters = [String : String]()
    
        let requestParam =  self.createExpManager.getMyExpParams()
        self.createExpManager.apiGetMyExperience(requestParam, completion: {
            
            if self.createExpManager.isSuccess {
                print(self.createExpManager.data)
                self.experienceModelArray = self.createExpManager.data!
                for expName in self.createExpManager.data!{
                    self.experienceListArray.append(expName.title!)
                }
            }
        })
    }
    
    func addPickerForExperienceList(){
//        let storyboard = UIStoryboard(name: "PickerViewModule", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController

        let expList = self.experienceListArray
        RPicker.selectOption(dataArray: expList) { (selctedText, atIndex) in
            self.experienceTxtField.text = selctedText
            for myExp in self.experienceModelArray{
                if (myExp.title == selctedText){
                    self.experienceId  = myExp.id
                    break
                }
            }
        }
        

//        vc.arrayOfData =
//        vc.pickerViewControllerSelectedDataDelegate = self as! PickerViewControllerSelectedDataDelegate
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    func getSelectedArrayIndex(selectedIndex: Int, andSelectedValue: String, andPickerType: PickerType) {
//
//    }
}



extension CreateStoryController{
    func checkValidationForCreateExp() -> Bool {
        
        
        guard let expId = experienceId, expId != nil else {
            return false
        }
        
        guard let title = self.storyTitleLabel.text, !title.isEmpty else {
            return false
        }
        
        guard let tags = tagsLabel.text, !tags.isEmpty else {
            return false
        }
        
        guard let videosData = videoData,expId != nil else {
            return false
        }
        
        
        return true
    }
}
