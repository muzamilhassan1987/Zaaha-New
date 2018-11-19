//
//	TypeBase.swift
//
//	Create by Faraz Haider on 18/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct TypeBase : Codable {

	let data : [TypeData]?
	let response : TypeResponse?


	enum CodingKeys: String, CodingKey {
		case data = "data"
		case response
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([TypeData].self, forKey: .data)
		response = try values.decodeIfPresent(TypeResponse.self, forKey: .response)
	}


}
