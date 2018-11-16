//
//	RegisterBase.swift
//
//	Create by Soomro Shahid on 14/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class RegisterBase : Codable {

	let data : UserData?
	let response : RegisterResponse?


	enum CodingKeys: String, CodingKey {
		case data
		case response
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(UserData.self, forKey: .data)  //?? RegisterData()
		response = try values.decodeIfPresent(RegisterResponse.self, forKey: .response)  //?? RegisterResponse()
	}


}
