//
//  Away.swift
//
//  Created by VinMac on 02/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Away: NSObject,NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let cc = "cc"
    static let imageId = "image_id"
    static let id = "id"
  }

  // MARK: Properties
  public var name: String?
  public var cc: String?
  public var imageId: String?
  public var id: String?

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
    name = json[SerializationKeys.name].string
    cc = json[SerializationKeys.cc].string
    imageId = json[SerializationKeys.imageId].string
    id = json[SerializationKeys.id].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = cc { dictionary[SerializationKeys.cc] = value }
    if let value = imageId { dictionary[SerializationKeys.imageId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.cc = aDecoder.decodeObject(forKey: SerializationKeys.cc) as? String
    self.imageId = aDecoder.decodeObject(forKey: SerializationKeys.imageId) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(cc, forKey: SerializationKeys.cc)
    aCoder.encode(imageId, forKey: SerializationKeys.imageId)
    aCoder.encode(id, forKey: SerializationKeys.id)
  }

}
