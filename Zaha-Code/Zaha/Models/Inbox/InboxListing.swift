//
//	InboxListing.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct InboxListing : Codable {

	let data : InboxData?
	let response : InboxResponse?


	enum CodingKeys: String, CodingKey {
		case data
		case response
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(InboxData.self, forKey: .data)
        response = try values.decodeIfPresent(InboxResponse.self, forKey: .response)
	}


}
