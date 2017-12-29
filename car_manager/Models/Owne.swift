//
//	Owne.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Owne{

	var owner : Owner!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let ownerData = dictionary["owner"] as? [String:Any]{
				owner = Owner(fromDictionary: ownerData)
			}
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if owner != nil{
			dictionary["owner"] = owner.toDictionary()
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}