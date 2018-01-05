//
//	InsideCar.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct InsideCar{

	var id : String!
	var inGate : Int!
	var inTime : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? String
		inGate = dictionary["in_gate"] as? Int
		inTime = dictionary["in_time"] as? Int
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
		if inGate != nil{
			dictionary["in_gate"] = inGate
		}
		if inTime != nil{
			dictionary["in_time"] = inTime
		}
		return dictionary
	}

}