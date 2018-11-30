//
//	InboxReceiverDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct InboxReceiverDetail : Codable {

	let cultureName : String?
	let experienceCount : Int?
	let id : Int?
	let imageUrl : String?
	let profileImage : String?
	let userName : String?
	let userRole : Int?


	enum CodingKeys: String, CodingKey {
		case cultureName = "culture_name"
		case experienceCount = "experience_count"
		case id = "id"
		case imageUrl = "image_url"
		case profileImage = "profile_image"
		case userName = "user_name"
		case userRole = "user_role"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cultureName = try values.decodeIfPresent(String.self, forKey: .cultureName)
		experienceCount = try values.decodeIfPresent(Int.self, forKey: .experienceCount)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
		userRole = try values.decodeIfPresent(Int.self, forKey: .userRole)
	}


}