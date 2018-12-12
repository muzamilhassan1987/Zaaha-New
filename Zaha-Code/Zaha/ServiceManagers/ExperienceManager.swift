//
//  CreateExperienceManager.swift
//  Zaha
//
//  Created by Faraz Haider on 18/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class ExperienceManager: AFManagerProtocol {
    var data : [MyExperienceExperiences]?
    var maestroNameData : [MaestroResult]?
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
    }
    
    
    var isSuccess = false
    var message  = ""
    
    
    func creteExpApiWithImage(_ param: AFParam,imageData : Data, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequestUpload(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                print(data)
                // let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: data)
                
                
                let model = try decoder.decode(RegisterBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    
                }else{
                    Alert.showMsg(msg: model.response?.message ?? "Server not responding")
                }
                
            } catch let err {
                
                print("Err", err)
            }
            
            completion()
        }) { (error) in
            
            completion()
        }
    }
    
    func creteStoryApiWithVideo(_ param: AFParam,videoData : Data, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequestUpload(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                print(data)
                // let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: data)
                
                
                let model = try decoder.decode(RegisterBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    
                }else{
                    Alert.showMsg(msg: model.response?.message ?? "Server not responding")
                }
                
            } catch let err {
                
                print("Err", err)
            }
            
            completion()
        }) { (error) in
            
            completion()
        }
    }
    
    
    func apiGetMyExperience(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: false, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(MyExperience.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
                    self.data = model.data?.experiences
                }else{
                    // Alert.showMsg(msg: model.response?.message ?? "Server not responding")
                }
                
            } catch let err {
                
                print("Err", err)
            }
            
            completion()
        }) { (error) in
            
            completion()
        }
    }
    
    
    func apiGetMaestro(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: false, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(MaestroBase.self, from: data)
                
                //check success case from server
                if model.code! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.message ?? " "
                    self.maestroNameData = model.result
                }else{
                    // Alert.showMsg(msg: model.response?.message ?? "Server not responding")
                }
                
            } catch let err {
                
                print("Err", err)
            }
            
            completion()
        }) { (error) in
            
            completion()
        }
    }
    
}

extension ExperienceManager {
    
    func paramsCreateExp(parameters : [String : AnyObject], img : UIImage) -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
                let imageCompressed = imageWithImage(image: img, scaledToSize: CGSize(width: 200, height: 200))
        print(CurrentUser.token)
        let param = AFParam(endpoint: "addExperience", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [imageCompressed])
        return param
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func paramsCreateStory(parameters : [String : AnyObject]) -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]

        let param = AFParam(endpoint: "addExperienceStory", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    func getMyExpParams() -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        let param = AFParam(endpoint: "getMyExperiences", params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    
    func postFilterParams() -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        let param = AFParam(endpoint: "upcomingExperienceFilter", params: [:], headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    func getMaestroNamesParams() -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        let param = AFParam(endpoint: "getMasteroesName", params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
}
