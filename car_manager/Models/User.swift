//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct User{

	var id : Int!
	var name : String!
	var password : String!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		password = dictionary["password"] as? String
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if password != nil{
			dictionary["password"] = password
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}