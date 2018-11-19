//
//	CreateExperienceRequest.swift
//
//	Create by Faraz Haider on 18/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CreateExperienceRequest : Codable {

	var amount : String?
	var cultureId : String?
	var descriptionField : String?
	var experienceTypeId : String?
	var explorers : String?
	var latitude : String?
	var location : String?
	var longitude : String?
	var publishDate : String?
	var publishTime : String?
	var title : String?


	enum CodingKeys: String, CodingKey {
		case amount = "experience_charges"
		case cultureId = "culture_id"
		case descriptionField = "description"
		case experienceTypeId = "experience_type_id"
		case explorers = "no_seats"
		case latitude = "latitude"
		case location = "location"
		case longitude = "longitude"
		case publishDate = "publish_date"
		case publishTime = "publish_time"
		case title = "title"
	}

    init() {
      
    }

}
