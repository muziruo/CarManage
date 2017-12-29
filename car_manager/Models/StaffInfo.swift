//
//	Info.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct StaffInfo{

	var car : [Car]!
	var staff : Staff!
	var unit : Unit!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		car = [Car]()
		if let carArray = dictionary["car"] as? [[String:Any]]{
			for dic in carArray{
				let value = Car(fromDictionary: dic)
				car.append(value)
			}
		}
		if let staffData = dictionary["staff"] as? [String:Any]{
				staff = Staff(fromDictionary: staffData)
			}
		if let unitData = dictionary["unit"] as? [String:Any]{
				unit = Unit(fromDictionary: unitData)
			}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if car != nil{
			var dictionaryElements = [[String:Any]]()
			for carElement in car {
				dictionaryElements.append(carElement.toDictionary())
			}
			dictionary["car"] = dictionaryElements
		}
		if staff != nil{
			dictionary["staff"] = staff.toDictionary()
		}
		if unit != nil{
			dictionary["unit"] = unit.toDictionary()
		}
		return dictionary
	}

}