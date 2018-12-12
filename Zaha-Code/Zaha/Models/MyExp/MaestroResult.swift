//
//	MaestroResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MaestroResult : Codable {

	let cultureId : Int?
	let cultureName : String?
	let email : String?
	let experienceCount : Int?
	let firstName : String?
	let id : Int?
	let imageUrl : String?
	let isNotify : String?
	let lastName : String?
	let profileImage : String?
	let rating : Int?
	let socialmediaId : String?
	let socialmediaType : String?
	let userName : String?
	let userRole : Int?


	enum CodingKeys: String, CodingKey {
		case cultureId = "culture_id"
		case cultureName = "culture_name"
		case email = "email"
		case experienceCount = "experience_count"
		case firstName = "first_name"
		case id = "id"
		case imageUrl = "image_url"
		case isNotify = "is_notify"
		case lastName = "last_name"
		case profileImage = "profile_image"
		case rating = "rating"
		case socialmediaId = "socialmedia_id"
		case socialmediaType = "socialmedia_type"
		case userName = "user_name"
		case userRole = "user_role"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cultureId = try values.decodeIfPresent(Int.self, forKey: .cultureId)
		cultureName = try values.decodeIfPresent(String.self, forKey: .cultureName)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		experienceCount = try values.decodeIfPresent(Int.self, forKey: .experienceCount)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		isNotify = try values.decodeIfPresent(String.self, forKey: .isNotify)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
		rating = try values.decodeIfPresent(Int.self, forKey: .rating)
		socialmediaId = try values.decodeIfPresent(String.self, forKey: .socialmediaId)
		socialmediaType = try values.decodeIfPresent(String.self, forKey: .socialmediaType)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
		userRole = try values.decodeIfPresent(Int.self, forKey: .userRole)
	}


}
