//
//	ChatMessages.swift
//
//	Create by Faraz Haider on 1/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ChatMessages : Codable {

	let createdAt : String?
	let deletedAt : String?
	let id : Int?
	let isActive : String?
	let isRead : Int?
	let message : String?
	let receiverDetail :  InboxReceiverDetail?
	let receiverId : Int?
	let senderDetail :  InboxReceiverDetail?
	let senderId : Int?
	let threadId : Int?
	let updatedAt : String?
	let data : ChatData?
	let response : ChatResponse?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case deletedAt = "deleted_at"
		case id = "id"
		case isActive = "is_active"
		case isRead = "is_read"
		case message = "message"
		case receiverDetail = "receiver_detail"
		case receiverId = "receiver_id"
		case senderDetail = "sender_detail"
		case senderId = "sender_id"
		case threadId = "thread_id"
		case updatedAt = "updated_at"
		case data = "data"
		case response = "response"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
		isRead = try values.decodeIfPresent(Int.self, forKey: .isRead)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		receiverDetail = try values.decodeIfPresent(InboxReceiverDetail.self, forKey: .receiverDetail)
		receiverId = try values.decodeIfPresent(Int.self, forKey: .receiverId)
		senderDetail = try values.decodeIfPresent(InboxReceiverDetail.self, forKey: .senderDetail)
		senderId = try values.decodeIfPresent(Int.self, forKey: .senderId)
		threadId = try values.decodeIfPresent(Int.self, forKey: .threadId)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
		data = try values.decodeIfPresent(ChatData.self, forKey: .data)
		response = try values.decodeIfPresent(ChatResponse.self, forKey: .response)
	}


}
