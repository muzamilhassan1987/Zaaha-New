//
//	CMSData.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CMSData : Codable {

	let createdAt : String?
	let deletedAt : String?
	let descriptionField : String?
	let id : Int?
	let isActive : String?
	let title : String?
	let type : String?
	let updatedAt : String?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case deletedAt = "deleted_at"
		case descriptionField = "description"
		case id = "id"
		case isActive = "is_active"
		case title = "title"
		case type = "type"
		case updatedAt = "updated_at"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? String()
		deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt) ?? String()
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		type = try values.decodeIfPresent(String.self, forKey: .type) ?? String()
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt) ?? String()
	}


}
