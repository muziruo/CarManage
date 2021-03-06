//
//	Car.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Car{

	var color : String!
	var id : String!
	var model : String!
	var seat : Int!
	var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		color = dictionary["color"] as? String
		id = dictionary["id"] as? String
		model = dictionary["model"] as? String
		seat = dictionary["seat"] as? Int
		type = dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if color != nil{
			dictionary["color"] = color
		}
		if id != nil{
			dictionary["id"] = id
		}
		if model != nil{
			dictionary["model"] = model
		}
		if seat != nil{
			dictionary["seat"] = seat
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}