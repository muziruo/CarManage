//
//	InOutNote.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct InOutNote{

	var car : String!
	var carPass : AnyObject!
	var fee : Float!
	var id : Int!
	var inGate : Int!
	var inTime : Int!
	var outGate : Int!
	var outTime : Int!
	var user : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		car = dictionary["car"] as? String
		carPass = dictionary["car_pass"] as? AnyObject
		fee = dictionary["fee"] as? Float
		id = dictionary["id"] as? Int
		inGate = dictionary["in_gate"] as? Int
		inTime = dictionary["in_time"] as? Int
		outGate = dictionary["out_gate"] as? Int
		outTime = dictionary["out_time"] as? Int
		user = dictionary["user"] as? Int
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
		if carPass != nil{
			dictionary["car_pass"] = carPass
		}
		if fee != nil{
			dictionary["fee"] = fee
		}
		if id != nil{
			dictionary["id"] = id
		}
		if inGate != nil{
			dictionary["in_gate"] = inGate
		}
		if inTime != nil{
			dictionary["in_time"] = inTime
		}
		if outGate != nil{
			dictionary["out_gate"] = outGate
		}
		if outTime != nil{
			dictionary["out_time"] = outTime
		}
		if user != nil{
			dictionary["user"] = user
		}
		return dictionary
	}

}