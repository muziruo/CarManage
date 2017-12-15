//
//	Car.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Car{

	var id : String!
	var type : Int!
	var unit : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? String
		type = dictionary["type"] as? Int
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
		if type != nil{
			dictionary["type"] = type
		}
		if unit != nil{
			dictionary["unit"] = unit
		}
		return dictionary
	}

}