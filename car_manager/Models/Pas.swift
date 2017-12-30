//
//	Pas.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Pas{

	var car : String!
	var createTime : Int!
	var fee : Float!
	var fromTime : Int!
	var id : Int!
	var owner : String!
	var toTime : Int!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		car = dictionary["car"] as? String
		createTime = dictionary["create_time"] as? Int
		fee = dictionary["fee"] as? Float
		fromTime = dictionary["from_time"] as? Int
		id = dictionary["id"] as? Int
		owner = dictionary["owner"] as? String
		toTime = dictionary["to_time"] as? Int
		type = dictionary["type"] as? Int
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
		if createTime != nil{
			dictionary["create_time"] = createTime
		}
		if fee != nil{
			dictionary["fee"] = fee
		}
		if fromTime != nil{
			dictionary["from_time"] = fromTime
		}
		if id != nil{
			dictionary["id"] = id
		}
		if owner != nil{
			dictionary["owner"] = owner
		}
		if toTime != nil{
			dictionary["to_time"] = toTime
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}