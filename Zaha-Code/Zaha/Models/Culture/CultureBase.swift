//
//	CultureBase.swift
//
//	Create by muzamilhassan on 16/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CultureBase : Codable {

	let data : [CultureData]?
	let response : CultureResponse?


	enum CodingKeys: String, CodingKey {
		case data = "data"
		case response
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([CultureData].self, forKey: .data) ?? [CultureData]()
		response = try values.decodeIfPresent(CultureResponse.self, forKey: .response)  //?? CultureResponse()
	}


}