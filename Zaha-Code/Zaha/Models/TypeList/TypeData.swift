//
//	TypeData.swift
//
//	Create by Faraz Haider on 18/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct TypeData : Codable {

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
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
	}


}
