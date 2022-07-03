//
//  Extra.swift
//
//  Created by VinMac on 09/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Extra: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let round = "round"
    static let stadiumData = "stadium_data"
    static let awayPos = "away_pos"
    static let periodlength = "periodlength"
    static let homePos = "home_pos"
    static let numberofperiods = "numberofperiods"
    static let length = "length"
  }

  // MARK: Properties
  public var round: String?
  public var stadiumData: StadiumData?
  public var awayPos: String?
  public var periodlength: String?
  public var homePos: String?
  public var numberofperiods: String?
  public var length: Int?

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
    round = json[SerializationKeys.round].string
    stadiumData = StadiumData(json: json[SerializationKeys.stadiumData])
    awayPos = json[SerializationKeys.awayPos].string
    periodlength = json[SerializationKeys.periodlength].string
    homePos = json[SerializationKeys.homePos].string
    numberofperiods = json[SerializationKeys.numberofperiods].string
    length = json[SerializationKeys.length].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = round { dictionary[SerializationKeys.round] = value }
    if let value = stadiumData { dictionary[SerializationKeys.stadiumData] = value.dictionaryRepresentation() }
    if let value = awayPos { dictionary[SerializationKeys.awayPos] = value }
    if let value = periodlength { dictionary[SerializationKeys.periodlength] = value }
    if let value = homePos { dictionary[SerializationKeys.homePos] = value }
    if let value = numberofperiods { dictionary[SerializationKeys.numberofperiods] = value }
    if let value = length { dictionary[SerializationKeys.length] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.round = aDecoder.decodeObject(forKey: SerializationKeys.round) as? String
    self.stadiumData = aDecoder.decodeObject(forKey: SerializationKeys.stadiumData) as? StadiumData
    self.awayPos = aDecoder.decodeObject(forKey: SerializationKeys.awayPos) as? String
    self.periodlength = aDecoder.decodeObject(forKey: SerializationKeys.periodlength) as? String
    self.homePos = aDecoder.decodeObject(forKey: SerializationKeys.homePos) as? String
    self.numberofperiods = aDecoder.decodeObject(forKey: SerializationKeys.numberofperiods) as? String
    self.length = aDecoder.decodeObject(forKey: SerializationKeys.length) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(round, forKey: SerializationKeys.round)
    aCoder.encode(stadiumData, forKey: SerializationKeys.stadiumData)
    aCoder.encode(awayPos, forKey: SerializationKeys.awayPos)
    aCoder.encode(periodlength, forKey: SerializationKeys.periodlength)
    aCoder.encode(homePos, forKey: SerializationKeys.homePos)
    aCoder.encode(numberofperiods, forKey: SerializationKeys.numberofperiods)
    aCoder.encode(length, forKey: SerializationKeys.length)
  }

}
