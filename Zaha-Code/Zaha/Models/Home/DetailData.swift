//
//	HomeData.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class DetailData : Codable {

	let experiences : HomeExperience?
//    let stories : [HomeStory]?


	enum CodingKeys: String, CodingKey {
		case experiences = "experiences"
		//case stories = "stories"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		experiences = try values.decodeIfPresent(HomeExperience.self, forKey: .experiences)
		//stories = try values.decodeIfPresent([HomeStory].self, forKey: .stories) ?? [HomeStory]()
	}


}
