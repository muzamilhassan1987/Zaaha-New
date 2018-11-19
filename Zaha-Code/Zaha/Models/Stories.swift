//
//	Stories.swift
//
//	Create by Faraz Haider on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Stories{

	var createdAt : String!
	var experienceId : Int!
	var experienceTitle : String!
	var id : Int!
	var status : String!
	var tags : String!
	var title : String!
	var userId : Int!
	var userName : String!
	var videoUrl : String!
	var youtubeUrl : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdAt = dictionary["created_at"] as? String
		experienceId = dictionary["experience_id"] as? Int
		experienceTitle = dictionary["experience_title"] as? String
		id = dictionary["id"] as? Int
		status = dictionary["status"] as? String
		tags = dictionary["tags"] as? String
		title = dictionary["title"] as? String
		userId = dictionary["user_id"] as? Int
		userName = dictionary["user_name"] as? String
		videoUrl = dictionary["video_url"] as? String
		youtubeUrl = dictionary["youtube_url"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if experienceId != nil{
			dictionary["experience_id"] = experienceId
		}
		if experienceTitle != nil{
			dictionary["experience_title"] = experienceTitle
		}
		if id != nil{
			dictionary["id"] = id
		}
		if status != nil{
			dictionary["status"] = status
		}
		if tags != nil{
			dictionary["tags"] = tags
		}
		if title != nil{
			dictionary["title"] = title
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if userName != nil{
			dictionary["user_name"] = userName
		}
		if videoUrl != nil{
			dictionary["video_url"] = videoUrl
		}
		if youtubeUrl != nil{
			dictionary["youtube_url"] = youtubeUrl
		}
		return dictionary
	}

}