//
//  GenericServerResponse.swift
//  Ezhalbatek-Technician
//
//  Created by Waqas Ali on 8/13/18.
//  Copyright © 2018 HassanKhan. All rights reserved.
//

import Foundation

class GenericServerResponse <T> : Codable where T: Encodable, T: Decodable {
    
    let message : String?
    let response : String?
    let data : T?
    
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case response = "response"
        case data = "data"
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
        response = try values.decodeIfPresent(String.self, forKey: .response) ?? String()
        data = try values.decodeIfPresent(T.self, forKey: .data)  //?? Result()
        
    }
}




class BaseResponse  : Codable  {
    
    let message : String?
    let response : String?
   
    
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case response = "response"
      
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
        response = try values.decodeIfPresent(String.self, forKey: .response) ?? String()
        
        
    }
}
