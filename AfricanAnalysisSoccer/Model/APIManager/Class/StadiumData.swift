//
//  StadiumData.swift
//
//  Created by VinMac on 09/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class StadiumData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let country = "country"
    static let name = "name"
    static let city = "city"
    static let capacity = "capacity"
    static let id = "id"
    static let googlecoords = "googlecoords"
  }

  // MARK: Properties
  public var country: String?
  public var name: String?
  public var city: String?
  public var capacity: String?
  public var id: String?
  public var googlecoords: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    country = json[SerializationKeys.country].string
    name = json[SerializationKeys.name].string
    city = json[SerializationKeys.city].string
    capacity = json[SerializationKeys.capacity].string
    id = json[SerializationKeys.id].string
    googlecoords = json[SerializationKeys.googlecoords].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = country { dictionary[SerializationKeys.country] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = capacity { dictionary[SerializationKeys.capacity] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = googlecoords { dictionary[SerializationKeys.googlecoords] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.capacity = aDecoder.decodeObject(forKey: SerializationKeys.capacity) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.googlecoords = aDecoder.decodeObject(forKey: SerializationKeys.googlecoords) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(country, forKey: SerializationKeys.country)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(capacity, forKey: SerializationKeys.capacity)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(googlecoords, forKey: SerializationKeys.googlecoords)
  }

}
