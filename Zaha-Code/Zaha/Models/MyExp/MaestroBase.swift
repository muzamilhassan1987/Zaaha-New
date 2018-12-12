//
//	MaestroBase.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MaestroBase : Codable {

	let code : Int?
	let message : String?
	let result : [MaestroResult]?
	let userBlocked : Int?
	let pages : Int?


	enum CodingKeys: String, CodingKey {
		case code = "Code"
		case message = "Message"
		case result = "Result"
		case userBlocked = "UserBlocked"
		case pages = "pages"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		result = try values.decodeIfPresent([MaestroResult].self, forKey: .result)
		userBlocked = try values.decodeIfPresent(Int.self, forKey: .userBlocked)
		pages = try values.decodeIfPresent(Int.self, forKey: .pages)
	}


}