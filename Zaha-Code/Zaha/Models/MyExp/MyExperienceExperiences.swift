//
//	MyExperienceExperiences.swift
//
//	Create by Faraz Haider on 25/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MyExperienceExperiences : Codable {

	let amount : String?
	let createdAt : String?
	let cultureId : Int?
	let cultureName : String?
	let descriptionField : String?
	let experienceTypeId : Int?
	let experienceTypeName : String?
	let id : Int?
	let imageUrl : String?
	let isActive : String?
	let location : String?
	let maestrosName : String?
	let noSeats : Int?
	let publishDate : String?
	let publishTime : String?
	let rating : Int?
	let reservationCharges : Int?
	let title : String?
	let totalBookings : Int?
	let totalPictures : Int?
	let totalStories : Int?
	let totalVideos : Int?
	let userId : Int?


	enum CodingKeys: String, CodingKey {
		case amount = "amount"
		case createdAt = "created_at"
		case cultureId = "culture_id"
		case cultureName = "culture_name"
		case descriptionField = "description"
		case experienceTypeId = "experience_type_id"
		case experienceTypeName = "experience_type_name"
		case id = "id"
		case imageUrl = "image_url"
		case isActive = "is_active"
		case location = "location"
		case maestrosName = "maestros_name"
		case noSeats = "no_seats"
		case publishDate = "publish_date"
		case publishTime = "publish_time"
		case rating = "rating"
		case reservationCharges = "reservation_charges"
		case title = "title"
		case totalBookings = "total_bookings"
		case totalPictures = "total_pictures"
		case totalStories = "total_stories"
		case totalVideos = "total_videos"
		case userId = "user_id"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		cultureId = try values.decodeIfPresent(Int.self, forKey: .cultureId)
		cultureName = try values.decodeIfPresent(String.self, forKey: .cultureName)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		experienceTypeId = try values.decodeIfPresent(Int.self, forKey: .experienceTypeId)
		experienceTypeName = try values.decodeIfPresent(String.self, forKey: .experienceTypeName)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		maestrosName = try values.decodeIfPresent(String.self, forKey: .maestrosName)
		noSeats = try values.decodeIfPresent(Int.self, forKey: .noSeats)
		publishDate = try values.decodeIfPresent(String.self, forKey: .publishDate)
		publishTime = try values.decodeIfPresent(String.self, forKey: .publishTime)
		rating = try values.decodeIfPresent(Int.self, forKey: .rating)
		reservationCharges = try values.decodeIfPresent(Int.self, forKey: .reservationCharges)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		totalBookings = try values.decodeIfPresent(Int.self, forKey: .totalBookings)
		totalPictures = try values.decodeIfPresent(Int.self, forKey: .totalPictures)
		totalStories = try values.decodeIfPresent(Int.self, forKey: .totalStories)
		totalVideos = try values.decodeIfPresent(Int.self, forKey: .totalVideos)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
	}


}
