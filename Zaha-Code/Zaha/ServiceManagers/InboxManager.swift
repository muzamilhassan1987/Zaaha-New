//
//  InboxManager.swift
//  Zaha
//
//  Created by Faraz Haider on 11/30/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class InboxManager: AFManagerProtocol {
    var data : [InboxThread]?
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
    }
    
    
    var isSuccess = false
    var message  = ""
    
    
    func apiGetMyInboxThreads(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: false, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(InboxListing.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
                    self.data = model.data?.threads
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

extension InboxManager {
    
    func paramsInboxListing() -> AFParam {
        
        let headers: [String : String] = ["token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjU0MSwiaXNzIjoiaHR0cHM6Ly90aGVicmFuZHN6b25lLmNvbS96YWhhLWFwcC9hcGkvcmVnaXN0ZXIiLCJpYXQiOjE1NDE0MzgyNDEsImV4cCI6MTU0NTAzODI0MSwibmJmIjoxNTQxNDM4MjQxLCJqdGkiOiJZZVM4bXhUMnVlUHcyOG1GIn0.FyGlfFIBEs963opxBzXnzvhM5MF56Nv98FLggNFHOQs"]
          let param = AFParam(endpoint: "getMyThreads", params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
}
