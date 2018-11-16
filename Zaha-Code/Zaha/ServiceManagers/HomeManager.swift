//
//  CMSManager.swift
//  Zaha
//
//  Created by muzamilhassan on 15/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class HomeManager: AFManagerProtocol {

    var isSuccess = false
    var message  = ""
    var data = [BaseHomeModel]()
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(HomeRootClass.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
//                    self.data =
                    self.data.append(contentsOf: model.data!.experiences!)
                    self.data.append(contentsOf: model.data!.stories!)
                    print(self.data)
//                    self.data = model.data!.experiences! + model.data!.stories!
                    
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

extension HomeManager {
    
    func paramsHome(_ type : BookingDetailEnum) -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        print(getEndPoint(type))
        let param = AFParam(endpoint: getEndPoint(type), params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    
    
    func getEndPoint(_ detailType :BookingDetailEnum) -> String {
        //"getHomeTimeLine"
        switch detailType {
        case .none:
            return "getHomeTimeLine"
            
        case .upcomingExperience:
            return "getUpComingExperience"
            
        case .booking:
            break
        case .stories:
            return "getStories"
            
        case .myExperience:
           
            break
        case .pastExperience:
            return "getPastExperience"
            
        default:
            print("")
        }

        return ""
    }
    
}
