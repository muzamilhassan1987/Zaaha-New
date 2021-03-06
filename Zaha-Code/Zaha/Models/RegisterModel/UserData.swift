//
//    RegisterData.swift
//
//    Create by Soomro Shahid on 14/11/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class UserData : Codable {
    
    let cultureId : Int?
    let cultureName : String?
    let email : String?
    let firstName : String?
    let id : Int?
    let imageUrl : String?
    var isNotify : String?
    let lastName : String?
    let profileImage : String?
    let rating : Int?
    let socialmediaId : String?
    let socialmediaType : String?
    let token : String?
    let userName : String?
    let userRole : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case cultureId = "culture_id"
        case cultureName = "culture_name"
        case email = "email"
        case firstName = "first_name"
        case id = "id"
        case imageUrl = "image_url"
        case isNotify = "is_notify"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case rating = "rating"
        case socialmediaId = "socialmedia_id"
        case socialmediaType = "socialmedia_type"
        case token = "token"
        case userName = "user_name"
        case userRole = "user_role"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cultureId = try values.decodeIfPresent(Int.self, forKey: .cultureId) ?? Int()
        cultureName = try values.decodeIfPresent(String.self, forKey: .cultureName) ?? String()
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? String()
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName) ?? String()
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? String()
        isNotify = try values.decodeIfPresent(String.self, forKey: .isNotify) ?? String()
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName) ?? String()
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage) ?? String()
        rating = try values.decodeIfPresent(Int.self, forKey: .rating) ?? Int()
        socialmediaId = try values.decodeIfPresent(String.self, forKey: .socialmediaId) ?? String()
        socialmediaType = try values.decodeIfPresent(String.self, forKey: .socialmediaType) ?? String()
        token = try values.decodeIfPresent(String.self, forKey: .token) ?? String()
        userName = try values.decodeIfPresent(String.self, forKey: .userName) ?? String()
        userRole = try values.decodeIfPresent(Int.self, forKey: .userRole) ?? Int()
    }
    
    
}
