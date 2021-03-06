

import Foundation
import Alamofire

class RegisterManager: AFManagerProtocol {
    
    
    var isSuccess = false
    var message  = ""
    var userData : UserData?
    
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
       
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(RegisterBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? "To complete the registration process, we have sent you a verification code on your email"
                   self.userData =  model.data
                   
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
    func apiForgotPassword(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(RegisterBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.response?.message ?? "To complete the registration process, we have sent you a verification code on your email"
                    self.userData =  model.data
                    
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
    func apiLogin(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
        
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(RegisterBase.self, from: data)
                
                //check success case from server
                if model.response?.responseCode! == ServiceCodes.successCode {
                    self.isSuccess = true
                    //self.message = model.response?.message ?? "To complete the registration process, we have sent you a verification code on your email"
                    self.userData =  model.data
                    
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
    
    
    func apiWithImage(_ param: AFParam,imageData : Data, completion: @escaping () -> Void) {
        
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
                    self.message = model.response?.message ?? "To complete the registration process, we have sent you a verification code on your email"
                    self.userData =  model.data
                    
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

extension RegisterManager {
    
    func paramsLogin(parameters : [String : AnyObject]) -> AFParam {
        
        let headers: [String : String] = [:]
        
        let param = AFParam(endpoint: "login", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    func params(parameters : [String : AnyObject]) -> AFParam {
        
        let headers: [String : String] = [:]
        
        let param = AFParam(endpoint: "register", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [])
        return param
    }
    
    
    func paramsForgotPassword(parameters : [String : AnyObject]) -> AFParam {
        
        let headers: [String : String] = [:]
        
        let param = AFParam(endpoint: "forgotPassword", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [])
         return param
    }
    
    func paramsWithImage(parameters : [String : AnyObject], img : UIImage) -> AFParam {
        
        let headers: [String : String] = [:]
        
        let imageCompressed = imageWithImage(image: img, scaledToSize: CGSize(width: 200, height: 200))
        let param = AFParam(endpoint: "register", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [imageCompressed])
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


