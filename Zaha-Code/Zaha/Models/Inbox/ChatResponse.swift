//
//	ChatResponse.swift
//
//	Create by Faraz Haider on 1/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ChatResponse : Codable {

	let errorCode : Int?
	let message : String?
	let responseCode : Int?


	enum CodingKeys: String, CodingKey {
		case errorCode = "error_code"
		case message = "message"
		case responseCode = "response_code"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
	}


}