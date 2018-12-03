//
//	HomeExperience.swift
//
//	Create by muzamilhassan on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class HomeExperience : Codable, BaseHomeModel {
    
    

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
    let pictures : [HomePicture]?
	let publishDate : String?
	let publishTime : String?
    let rating : Int?
    let reservationCharges : Int?
    let reviews : [HomeReview]?
    let stories : [HomeStory]?
    let totalBookings : Int?
    let totalPictures : Int?
    let totalStories : Int?
    let totalVideos : Int?
	let title : String?
	let userId : Int?
    let sortingDate : Date?
    var bookingStatus : Int?
    var isPublished : Int?
    let videos : [HomeVideo]?
    
    
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
		case publishDate = "publish_date"
		case publishTime = "publish_time"
		case title = "title"
		case userId = "user_id"
        case bookingStatus = "booking_status"
        case noSeats = "no_seats"
        case rating = "rating"
        case reservationCharges = "reservation_charges"
        case totalBookings = "total_bookings"
        case totalPictures = "total_pictures"
        case totalStories = "total_stories"
        case totalVideos = "total_videos"
        case pictures = "pictures"
        case reviews = "reviews"
        case stories = "stories"
        case videos = "videos"
        case isPublished = "is_published"
        
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(String.self, forKey: .amount) ?? String()
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? String()
		cultureId = try values.decodeIfPresent(Int.self, forKey: .cultureId) ?? Int()
		cultureName = try values.decodeIfPresent(String.self, forKey: .cultureName) ?? String()
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		experienceTypeId = try values.decodeIfPresent(Int.self, forKey: .experienceTypeId) ?? Int()
		experienceTypeName = try values.decodeIfPresent(String.self, forKey: .experienceTypeName) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? String()
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive) ?? String()
		location = try values.decodeIfPresent(String.self, forKey: .location) ?? String()
		maestrosName = try values.decodeIfPresent(String.self, forKey: .maestrosName) ?? String()
		publishDate = try values.decodeIfPresent(String.self, forKey: .publishDate) ?? String()
		publishTime = try values.decodeIfPresent(String.self, forKey: .publishTime) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? Int()
        bookingStatus = try values.decodeIfPresent(Int.self, forKey: .bookingStatus) ?? Int()
        isPublished = try values.decodeIfPresent(Int.self, forKey: .isPublished) ?? Int()
        noSeats = try values.decodeIfPresent(Int.self, forKey: .noSeats) ?? Int()
        rating = try values.decodeIfPresent(Int.self, forKey: .rating) ?? Int()
        
        reservationCharges = try values.decodeIfPresent(Int.self, forKey: .reservationCharges) ?? Int()
        totalBookings = try values.decodeIfPresent(Int.self, forKey: .totalBookings) ?? Int()
        totalPictures = try values.decodeIfPresent(Int.self, forKey: .totalPictures) ?? Int()
        totalStories = try values.decodeIfPresent(Int.self, forKey: .totalStories) ?? Int()
        totalVideos = try values.decodeIfPresent(Int.self, forKey: .totalVideos) ?? Int()
        pictures = try values.decodeIfPresent([HomePicture].self, forKey: .pictures) ?? [HomePicture]()
        
        reviews = try values.decodeIfPresent([HomeReview].self, forKey: .reviews) ?? [HomeReview]()
        stories = try values.decodeIfPresent([HomeStory].self, forKey: .stories) ?? [HomeStory]()
        videos = try values.decodeIfPresent([HomeVideo].self, forKey: .videos) ?? [HomeVideo]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        sortingDate = dateFormatter.date(from: createdAt!)
        print(sortingDate)
        
	}
    var sortingDateNew : Date? {
        return sortingDate
    }

}
