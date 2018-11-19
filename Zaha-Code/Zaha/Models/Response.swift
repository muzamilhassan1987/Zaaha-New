//
//	Response.swift
//
//	Create by Faraz Haider on 15/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Response{

	var errorCode : Int!
	var message : String!
	var responseCode : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		errorCode = dictionary["error_code"] as? Int
		message = dictionary["message"] as? String
		responseCode = dictionary["response_code"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if errorCode != nil{
			dictionary["error_code"] = errorCode
		}
		if message != nil{
			dictionary["message"] = message
		}
		if responseCode != nil{
			dictionary["response_code"] = responseCode
		}
		return dictionary
	}

}