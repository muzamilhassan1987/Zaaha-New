//
//  CMSManager.swift
//  Zaha
//
//  Created by muzamilhassan on 15/11/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire

class DetailPostManager: AFManagerProtocol {

    var isSuccess = false
    var message  = ""
    var data = [BaseHomeModel]()
    var experienceData : HomeExperience?
//    var data = HomeExperience()
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(DetailExperienceBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? " "
                    self.experienceData = model.data?.experiences!
                    print(self.experienceData?.id)
//                    self.data =
                    //self.data.append(contentsOf: model.data!.experiences!)
                    //self.data.append(contentsOf: model.data!.stories!)
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

extension DetailPostManager {
    
    func paramsDetail(_ parameters : [String : AnyObject], type : BookingDetailEnum) -> AFParam {
        //getCms?type=(term_condition,privacy_policy,about_us)
        let headers: [String : String] = ["token":CurrentUser.data!.token!]
        
        print(CurrentUser.token)
        print("---------------------------------------------------")
        print(getEndPoint(type))
        print(parameters)
//        if (type == .nearMe) {
//            var parameters = [String : String]()
//            parameters.updateValue(CurrentUser., forKey: "password")
//            parameters.updateValue(getString(dict["text"]), forKey: "password")
//            let param = AFParam(endpoint: getEndPoint(type), params: [:], headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
//            return param
//        }
        let param = AFParam(endpoint: getEndPoint(type), params: parameters, headers: headers, method: .get, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    
    
    func getEndPoint(_ detailType :BookingDetailEnum) -> String {
        //"getHomeTimeLine"
        switch detailType {
        case .none:
            return "getHomeTimeLine"
            
        case .upcomingExperience:
            return "getUpComingExperienceById"
            
        case .booking:
            break
        case .stories:
            return "getStories"
            
        case .myExperience:
            return "getMyExperiences"
            break
        case .pastExperience:
            return "getPastExperienceById"
            
        case .nearMe:
            //return "getNearByExperience?latitude=23.7888&longitude=-23.7888"
            return "getUpComingExperienceById"
        default:
            print("")
        }

        return ""
    }
    
}
