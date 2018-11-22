//
//	CulturePicture.swift
//
//	Create by muzamilhassan on 22/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class HomePicture : Codable {

	let experienceId : Int?
	let id : Int?
	let imageUrl : String?
	let userId : Int?
	let userName : String?


	enum CodingKeys: String, CodingKey {
		case experienceId = "experience_id"
		case id = "id"
		case imageUrl = "image_url"
		case userId = "user_id"
		case userName = "user_name"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		experienceId = try values.decodeIfPresent(Int.self, forKey: .experienceId) ?? Int()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? String()
		userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? Int()
		userName = try values.decodeIfPresent(String.self, forKey: .userName) ?? String()
	}


}
