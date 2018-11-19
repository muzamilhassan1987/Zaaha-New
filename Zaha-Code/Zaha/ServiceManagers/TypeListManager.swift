//
//  TypeListManager.swift
//  Zaha
//
//  Created by Faraz Haider on 18/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class TypeListManager: AFManagerProtocol {
    
    var isSuccess = false
    var message  = ""
    var data : [TypeData]?
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
    }
    func apiGetTypeList(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: false, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(TypeBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
                    self.data = model.data!
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
extension TypeListManager {
    
    func params() -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        let param = AFParam(endpoint: "getExperienceType", params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
}
