//
//  CMSManager.swift
//  Zaha
//
//  Created by muzamilhassan on 15/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class CMSManager: AFManagerProtocol {

    var isSuccess = false
    var message  = ""
    var data : CMSData?
    var htmlString = ""
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(CMSBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
                    self.data = model.data
                    let str = "<div style=\"color:#5A5A5A; font-size: \(DesignUtility.getFontSize(fSize: 18))px\"><font face=\"HelveticaNeue\">\(model.data?.descriptionField! ?? "<p>html</p>")</font></div>"
                    self.htmlString = str
                    
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

extension CMSManager {
    
    func paramsCMS(parameters : [String : AnyObject]) -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = [:]
        
        let param = AFParam(endpoint: "getCms", params: parameters, headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    
}
