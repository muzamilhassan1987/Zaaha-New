//
//	InboxThread.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct InboxThread : Codable {

	let createdAt : String?
	let deletedAt : String?
	let experienceId : Int?
	let experienceTitle : String?
	let id : Int?
	let isActive : String?
	let isRead : Int?
	let message : String?
	let receiverDetail : InboxReceiverDetail?
	let receiverId : Int?
	let senderDetail : InboxReceiverDetail?
	let senderId : Int?
	let unreadMessageCount : Int?
	let updatedAt : String?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case deletedAt = "deleted_at"
		case experienceId = "experience_id"
		case experienceTitle = "experience_title"
		case id = "id"
		case isActive = "is_active"
		case isRead = "is_read"
		case message = "message"
		case receiverDetail = "receiver_detail"
		case receiverId = "receiver_id"
		case senderDetail = "sender_detail"
		case senderId = "sender_id"
		case unreadMessageCount = "unread_message_count"
		case updatedAt = "updated_at"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
		experienceId = try values.decodeIfPresent(Int.self, forKey: .experienceId)
		experienceTitle = try values.decodeIfPresent(String.self, forKey: .experienceTitle)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
		isRead = try values.decodeIfPresent(Int.self, forKey: .isRead)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		receiverDetail = try values.decodeIfPresent(InboxReceiverDetail.self, forKey: .receiverDetail)
		receiverId = try values.decodeIfPresent(Int.self, forKey: .receiverId)
		senderDetail = try values.decodeIfPresent(InboxReceiverDetail.self, forKey: .senderDetail)
		senderId = try values.decodeIfPresent(Int.self, forKey: .senderId)
		unreadMessageCount = try values.decodeIfPresent(Int.self, forKey: .unreadMessageCount)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
	}


}
