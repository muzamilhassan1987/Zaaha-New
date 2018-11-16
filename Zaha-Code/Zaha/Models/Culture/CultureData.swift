//
//	CultureData.swift
//
//	Create by muzamilhassan on 16/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CultureData : Codable {

	let createdAt : String?
	let deletedAt : String?
	let id : Int?
	let isActive : String?
	let title : String?
	let updatedAt : String?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case deletedAt = "deleted_at"
		case id = "id"
		case isActive = "is_active"
		case title = "title"
		case updatedAt = "updated_at"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? String()
		deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt) ?? String()
	}


}
