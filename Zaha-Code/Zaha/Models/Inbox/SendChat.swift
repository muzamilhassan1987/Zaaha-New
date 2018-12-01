//
//	SendChat.swift
//
//	Create by Faraz Haider on 1/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SendChat : Codable {

	let response : SendChatResponse?


	enum CodingKeys: String, CodingKey {
		case response
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		response = try values.decodeIfPresent(SendChatResponse.self, forKey: .response)
	}


}
