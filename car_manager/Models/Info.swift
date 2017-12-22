//
//	Info.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Info{

	var car : Car!
	var fillUp : [AnyObject]!
	var inOutNote : [AnyObject]!
	var ticket : [AnyObject]!
	var upkeep : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let carData = dictionary["car"] as? [String:Any]{
				car = Car(fromDictionary: carData)
			}
		fillUp = dictionary["fill_up"] as? [AnyObject]
		inOutNote = dictionary["in_out_note"] as? [AnyObject]
		ticket = dictionary["ticket"] as? [AnyObject]
		upkeep = dictionary["upkeep"] as? [AnyObject]
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if car != nil{
			dictionary["car"] = car.toDictionary()
		}
		if fillUp != nil{
			dictionary["fill_up"] = fillUp
		}
		if inOutNote != nil{
			dictionary["in_out_note"] = inOutNote
		}
		if ticket != nil{
			dictionary["ticket"] = ticket
		}
		if upkeep != nil{
			dictionary["upkeep"] = upkeep
		}
		return dictionary
	}

}
