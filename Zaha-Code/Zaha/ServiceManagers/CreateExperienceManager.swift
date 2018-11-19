//
//  CreateExperienceManager.swift
//  Zaha
//
//  Created by Faraz Haider on 18/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class CreateExperienceManager: AFManagerProtocol {

    
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
}

extension CreateExperienceManager {
    
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
}
