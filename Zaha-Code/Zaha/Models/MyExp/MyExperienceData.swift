//
//	MyExperienceData.swift
//
//	Create by Faraz Haider on 25/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MyExperienceData : Codable {

	let experiences : [MyExperienceExperiences]?


	enum CodingKeys: String, CodingKey {
		case experiences = "experiences"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		experiences = try values.decodeIfPresent([MyExperienceExperiences].self, forKey: .experiences)
	}


}