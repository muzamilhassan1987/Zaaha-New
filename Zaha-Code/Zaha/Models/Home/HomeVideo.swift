//
//	CultureVideo.swift
//
//	Create by muzamilhassan on 22/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class HomeVideo : Codable {

	let experienceId : Int?
	let id : Int?
	let userId : Int?
	let userName : String?
	let video : String?
	let videoThumbUrl : String?
	let videoUrl : String?
	let youtubeUrl : String?


	enum CodingKeys: String, CodingKey {
		case experienceId = "experience_id"
		case id = "id"
		case userId = "user_id"
		case userName = "user_name"
		case video = "video"
		case videoThumbUrl = "video_thumb_url"
		case videoUrl = "video_url"
		case youtubeUrl = "youtube_url"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		experienceId = try values.decodeIfPresent(Int.self, forKey: .experienceId) ?? Int()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? Int()
		userName = try values.decodeIfPresent(String.self, forKey: .userName) ?? String()
		video = try values.decodeIfPresent(String.self, forKey: .video) ?? String()
		videoThumbUrl = try values.decodeIfPresent(String.self, forKey: .videoThumbUrl) ?? String()
		videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl) ?? String()
		youtubeUrl = try values.decodeIfPresent(String.self, forKey: .youtubeUrl) ?? String()
	}


}
