//
//	MyExperience.swift
//
//	Create by Faraz Haider on 25/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MyExperience : Codable {

	let data : MyExperienceData?
	let response : MyExperienceResponse?


	enum CodingKeys: String, CodingKey {
		case data
		case response
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(MyExperienceData.self, forKey: .data)
		response =  try values.decodeIfPresent(MyExperienceResponse.self, forKey: .response)
	}


}
