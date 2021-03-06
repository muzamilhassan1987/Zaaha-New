//
//	HomeData.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class HomeData : Codable {

	let experiences : [HomeExperience]?
	let stories : [HomeStory]?
    let bookings : [HomeExperience]?

	enum CodingKeys: String, CodingKey {
		case experiences = "experiences"
		case stories = "stories"
        case bookings = "bookings"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		experiences = try values.decodeIfPresent([HomeExperience].self, forKey: .experiences) ?? [HomeExperience]()
        bookings = try values.decodeIfPresent([HomeExperience].self, forKey: .bookings) ?? [HomeExperience]()
		stories = try values.decodeIfPresent([HomeStory].self, forKey: .stories) ?? [HomeStory]()
	}


}
