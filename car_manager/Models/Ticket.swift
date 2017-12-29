//
//	Ticket.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Ticket{

	var car : String!
	var id : Int!
	var time : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		car = dictionary["car"] as? String
		id = dictionary["id"] as? Int
		time = dictionary["time"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if car != nil{
			dictionary["car"] = car
		}
		if id != nil{
			dictionary["id"] = id
		}
		if time != nil{
			dictionary["time"] = time
		}
		return dictionary
	}

}