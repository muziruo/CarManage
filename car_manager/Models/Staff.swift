//
//	Staff.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Staff{

	var id : String!
	var name : String!
	var phone : String!
	var unit : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		phone = dictionary["phone"] as? String
		unit = dictionary["unit"] as? String
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
		if phone != nil{
			dictionary["phone"] = phone
		}
		if unit != nil{
			dictionary["unit"] = unit
		}
		return dictionary
	}

}
