//
//	CMSBase.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CMSBase : Codable {

	let data : CMSData?
	let response : CMSResponse?


	enum CodingKeys: String, CodingKey {
		case data
		case response
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(CMSData.self, forKey: .data)  //?? CMSData()
		response = try values.decodeIfPresent(CMSResponse.self, forKey: .response)  //?? CMSResponse()
	}


}