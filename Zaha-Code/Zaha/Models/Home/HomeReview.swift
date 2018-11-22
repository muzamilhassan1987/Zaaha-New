//
//	CultureReview.swift
//
//	Create by muzamilhassan on 22/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class HomeReview : Codable {

	let authenticityFood : Int?
	let cleanlinessEnvironment : Int?
	let dynamicGroup : Int?
	let experienceId : Int?
	let id : Int?
	let levelEngagement : Int?
	let maestroAvgRating : Int?
	let review : String?
	let userId : Int?
	let userName : String?


	enum CodingKeys: String, CodingKey {
		case authenticityFood = "authenticity_food"
		case cleanlinessEnvironment = "cleanliness_environment"
		case dynamicGroup = "dynamic_group"
		case experienceId = "experience_id"
		case id = "id"
		case levelEngagement = "level_engagement"
		case maestroAvgRating = "maestro_avg_rating"
		case review = "review"
		case userId = "user_id"
		case userName = "user_name"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		authenticityFood = try values.decodeIfPresent(Int.self, forKey: .authenticityFood) ?? Int()
		cleanlinessEnvironment = try values.decodeIfPresent(Int.self, forKey: .cleanlinessEnvironment) ?? Int()
		dynamicGroup = try values.decodeIfPresent(Int.self, forKey: .dynamicGroup) ?? Int()
		experienceId = try values.decodeIfPresent(Int.self, forKey: .experienceId) ?? Int()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		levelEngagement = try values.decodeIfPresent(Int.self, forKey: .levelEngagement) ?? Int()
		maestroAvgRating = try values.decodeIfPresent(Int.self, forKey: .maestroAvgRating) ?? Int()
		review = try values.decodeIfPresent(String.self, forKey: .review) ?? String()
		userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? Int()
		userName = try values.decodeIfPresent(String.self, forKey: .userName) ?? String()
	}


}
