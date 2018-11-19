//
//	CommonServerResponse.swift
//
//	Create by Faraz Haider on 18/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CommonServerResponse : Codable {
	let response : CommonResponse?


	enum CodingKeys: String, CodingKey {
		case response
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		response = try CommonResponse(from: decoder)
	}


}
