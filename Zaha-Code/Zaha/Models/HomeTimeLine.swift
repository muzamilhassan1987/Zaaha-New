//
//	HomeTimeLine.swift
//
//	Create by Faraz Haider on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HomeTimeLine{

	var experiences : [Experiences]!
	var stories : [Stories]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		experiences = [Experiences]()
		if let experiencesArray = dictionary["experiences"] as? [[String:Any]]{
			for dic in experiencesArray{
				let value = Experiences(fromDictionary: dic)
				experiences.append(value)
			}
		}
		stories = [Stories]()
		if let storiesArray = dictionary["stories"] as? [[String:Any]]{
			for dic in storiesArray{
				let value = Stories(fromDictionary: dic)
				stories.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if experiences != nil{
			var dictionaryElements = [[String:Any]]()
			for experiencesElement in experiences {
				dictionaryElements.append(experiencesElement.toDictionary())
			}
			dictionary["experiences"] = dictionaryElements
		}
		if stories != nil{
			var dictionaryElements = [[String:Any]]()
			for storiesElement in stories {
				dictionaryElements.append(storiesElement.toDictionary())
			}
			dictionary["stories"] = dictionaryElements
		}
		return dictionary
	}

}