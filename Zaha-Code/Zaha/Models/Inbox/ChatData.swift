//
//	ChatData.swift
//
//	Create by Faraz Haider on 1/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ChatData : Codable {

	let messages : [ChatMessages]?


	enum CodingKeys: String, CodingKey {
		case messages = "messages"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		messages = try values.decodeIfPresent([ChatMessages].self, forKey: .messages)
	}


}