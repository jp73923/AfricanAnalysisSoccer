//
//  Timer.swift
//
//  Created by VinMac on 09/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Timer: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let ta = "ta"
    static let tm = "tm"
    static let md = "md"
    static let ts = "ts"
    static let tt = "tt"
  }

  // MARK: Properties
  public var ta: Int?
  public var tm: Int?
  public var md: Int?
  public var ts: Int?
  public var tt: String?

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
    ta = json[SerializationKeys.ta].int
    tm = json[SerializationKeys.tm].int
    md = json[SerializationKeys.md].int
    ts = json[SerializationKeys.ts].int
    tt = json[SerializationKeys.tt].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = ta { dictionary[SerializationKeys.ta] = value }
    if let value = tm { dictionary[SerializationKeys.tm] = value }
    if let value = md { dictionary[SerializationKeys.md] = value }
    if let value = ts { dictionary[SerializationKeys.ts] = value }
    if let value = tt { dictionary[SerializationKeys.tt] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.ta = aDecoder.decodeObject(forKey: SerializationKeys.ta) as? Int
    self.tm = aDecoder.decodeObject(forKey: SerializationKeys.tm) as? Int
    self.md = aDecoder.decodeObject(forKey: SerializationKeys.md) as? Int
    self.ts = aDecoder.decodeObject(forKey: SerializationKeys.ts) as? Int
    self.tt = aDecoder.decodeObject(forKey: SerializationKeys.tt) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(ta, forKey: SerializationKeys.ta)
    aCoder.encode(tm, forKey: SerializationKeys.tm)
    aCoder.encode(md, forKey: SerializationKeys.md)
    aCoder.encode(ts, forKey: SerializationKeys.ts)
    aCoder.encode(tt, forKey: SerializationKeys.tt)
  }

}
