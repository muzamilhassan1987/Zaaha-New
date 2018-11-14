//
//  HomeManager.swift
//  Zaha
//
//  Created by Faraz Haider on 14/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON


class HomeManager: AFManagerProtocol {
    var isSuccess = false
    var homeTimeLineData: [String : Any] = [:]
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }


                let swiftyJsonVar = JSON(data)
                
            if let responseData = swiftyJsonVar["response"].dictionaryObject{
                let response = Response(fromDictionary: responseData)
                    if response.responseCode == 200 {
                        if let responseData = swiftyJsonVar["data"].dictionaryObject{
                            self.homeTimeLineData = responseData
                        self.isSuccess = true
                        }else{
                           Alert.showMsg(msg: response.message ?? "Server not responding")
                        }
                    }else{
                        Alert.showMsg(msg: response.message ?? "Server not responding")
                    }
            completion()
            }else{
                Alert.showMsg(msg:"Server not responding")
            }
        }) { (error) in
            
            completion()
        }
    }
}

extension HomeManager {
    // parameters : [String : AnyObject]
    func params() -> AFParam {
        
        let headers: [String : String] = ["token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjU0NiwiaXNzIjoiaHR0cHM6Ly90aGVicmFuZHN6b25lLmNvbS96YWhhLWFwcC9hcGkvbG9naW4iLCJpYXQiOjE1NDIwNDg0MDMsImV4cCI6MTU0NTY0ODQwMywibmJmIjoxNTQyMDQ4NDAzLCJqdGkiOiI1ZGx1MnlZenlrWVRUeTRpIn0.KnEA2RtVblZmifs0Nta4LKteKrj8yMtfeP9nCy5-s08"]
        
//        let parameters = [
//            "user_id": CurrentUser.data!.id,
//            "old_password": oldPass,
//            "password":newPass,
//            ] as [String : AnyObject]
        
        let param = AFParam(endpoint: "getHomeTimeLine", params:[:] , headers: headers, method: .get, parameterEncoding: JSONEncoding.default, images: [])
        
        return param
    }
}
