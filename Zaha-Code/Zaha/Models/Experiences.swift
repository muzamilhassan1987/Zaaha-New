//
//	Experiences.swift
//
//	Create by Faraz Haider on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Experiences{

	var amount : String!
	var createdAt : String!
	var cultureId : Int!
	var cultureName : String!
	var descriptionField : String!
	var experienceTypeId : Int!
	var experienceTypeName : String!
	var id : Int!
	var imageUrl : String!
	var isActive : String!
	var location : String!
	var maestrosName : String!
	var publishDate : String!
	var publishTime : String!
	var title : String!
	var userId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		amount = dictionary["amount"] as? String
		createdAt = dictionary["created_at"] as? String
		cultureId = dictionary["culture_id"] as? Int
		cultureName = dictionary["culture_name"] as? String
		descriptionField = dictionary["description"] as? String
		experienceTypeId = dictionary["experience_type_id"] as? Int
		experienceTypeName = dictionary["experience_type_name"] as? String
		id = dictionary["id"] as? Int
		imageUrl = dictionary["image_url"] as? String
		isActive = dictionary["is_active"] as? String
		location = dictionary["location"] as? String
		maestrosName = dictionary["maestros_name"] as? String
		publishDate = dictionary["publish_date"] as? String
		publishTime = dictionary["publish_time"] as? String
		title = dictionary["title"] as? String
		userId = dictionary["user_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if amount != nil{
			dictionary["amount"] = amount
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if cultureId != nil{
			dictionary["culture_id"] = cultureId
		}
		if cultureName != nil{
			dictionary["culture_name"] = cultureName
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if experienceTypeId != nil{
			dictionary["experience_type_id"] = experienceTypeId
		}
		if experienceTypeName != nil{
			dictionary["experience_type_name"] = experienceTypeName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imageUrl != nil{
			dictionary["image_url"] = imageUrl
		}
		if isActive != nil{
			dictionary["is_active"] = isActive
		}
		if location != nil{
			dictionary["location"] = location
		}
		if maestrosName != nil{
			dictionary["maestros_name"] = maestrosName
		}
		if publishDate != nil{
			dictionary["publish_date"] = publishDate
		}
		if publishTime != nil{
			dictionary["publish_time"] = publishTime
		}
		if title != nil{
			dictionary["title"] = title
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		return dictionary
	}

}