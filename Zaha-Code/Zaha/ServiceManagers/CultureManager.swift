//
//  CultureManager.swift
//  Zaha
//
//  Created by muzamilhassan on 16/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class CultureManager: AFManagerProtocol {
    
    var isSuccess = false
    var message  = ""
    var data : [CultureData]?
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
    }
    func apiGetCultureList(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: false, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(CultureBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
                    self.data = model.data!
                    //                    self.data =
//                    self.data.append(contentsOf: model.data!.experiences!)
//                    self.data.append(contentsOf: model.data!.stories!)
//                    print(self.data)
                    //                    self.data = model.data!.experiences! + model.data!.stories!
                    
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
extension CultureManager {
    
    func params() -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        let param = AFParam(endpoint: "getCulture", params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    
}
