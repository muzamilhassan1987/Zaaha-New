//
//	InboxData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct InboxData : Codable {

	let threads : [InboxThread]?


	enum CodingKeys: String, CodingKey {
		case threads = "threads"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		threads = try values.decodeIfPresent([InboxThread].self, forKey: .threads)
	}


}