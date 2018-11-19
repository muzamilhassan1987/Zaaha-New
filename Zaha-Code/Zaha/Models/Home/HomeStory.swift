//
//	HomeStory.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class HomeStory : Codable, BaseHomeModel {

    

	let createdAt : String?
	let experienceId : Int?
	let experienceTitle : String?
	let id : Int?
	let status : String?
	let tags : String?
	let title : String?
	let userId : Int?
	let userName : String?
	let videoUrl : String?
	let youtubeUrl : String?
    let sortingDate : Date?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case experienceId = "experience_id"
		case experienceTitle = "experience_title"
		case id = "id"
		case status = "status"
		case tags = "tags"
		case title = "title"
		case userId = "user_id"
		case userName = "user_name"
		case videoUrl = "video_url"
		case youtubeUrl = "youtube_url"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? String()
		experienceId = try values.decodeIfPresent(Int.self, forKey: .experienceId) ?? Int()
		experienceTitle = try values.decodeIfPresent(String.self, forKey: .experienceTitle) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		status = try values.decodeIfPresent(String.self, forKey: .status) ?? String()
		tags = try values.decodeIfPresent(String.self, forKey: .tags) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? Int()
		userName = try values.decodeIfPresent(String.self, forKey: .userName) ?? String()
		videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl) ?? String()
		youtubeUrl = try values.decodeIfPresent(String.self, forKey: .youtubeUrl) ?? String()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        sortingDate = dateFormatter.date(from: createdAt!)
        print(sortingDate)
        
	}
    
    var sortingDateNew : Date? {
        return sortingDate
    }


}
