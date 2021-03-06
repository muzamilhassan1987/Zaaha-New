//
//	HomeRootClass.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class DetailExperienceBase : Codable {

	let data : DetailData?
	let response : HomeResponse?


	enum CodingKeys: String, CodingKey {
		case data
		case response
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(DetailData.self, forKey: .data)  //?? HomeData()
		response = try values.decodeIfPresent(HomeResponse.self, forKey: .response)  //?? HomeResponse()
	}


}
