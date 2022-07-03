//
//  ClassLeague.swift
//
//  Created by VinMac on 02/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ClassLeague: NSObject,NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let score = "score"
    static let gameId = "game_id"
    static let away = "away"
    static let league = "league"
    static let home = "home"
    static let timeStatus = "time_status"
    static let time = "time"
    static let timer = "timer"
    static let bet365Id = "bet365_id"
  }

  // MARK: Properties
  public var score: String?
  public var gameId: String?
  public var away: Away?
  public var league: League?
  public var home: Home?
  public var timeStatus: String?
  public var time: String?
  public var timer: String?
  public var bet365Id: String?

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
    score = json[SerializationKeys.score].string
    gameId = json[SerializationKeys.gameId].string
    away = Away(json: json[SerializationKeys.away])
    league = League(json: json[SerializationKeys.league])
    home = Home(json: json[SerializationKeys.home])
    timeStatus = json[SerializationKeys.timeStatus].string
    time = json[SerializationKeys.time].string
    timer = json[SerializationKeys.timer].string
    bet365Id = json[SerializationKeys.bet365Id].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = score { dictionary[SerializationKeys.score] = value }
    if let value = gameId { dictionary[SerializationKeys.gameId] = value }
    if let value = away { dictionary[SerializationKeys.away] = value.dictionaryRepresentation() }
    if let value = league { dictionary[SerializationKeys.league] = value.dictionaryRepresentation() }
    if let value = home { dictionary[SerializationKeys.home] = value.dictionaryRepresentation() }
    if let value = timeStatus { dictionary[SerializationKeys.timeStatus] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = timer { dictionary[SerializationKeys.timer] = value }
    if let value = bet365Id { dictionary[SerializationKeys.bet365Id] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.score = aDecoder.decodeObject(forKey: SerializationKeys.score) as? String
    self.gameId = aDecoder.decodeObject(forKey: SerializationKeys.gameId) as? String
    self.away = aDecoder.decodeObject(forKey: SerializationKeys.away) as? Away
    self.league = aDecoder.decodeObject(forKey: SerializationKeys.league) as? League
    self.home = aDecoder.decodeObject(forKey: SerializationKeys.home) as? Home
    self.timeStatus = aDecoder.decodeObject(forKey: SerializationKeys.timeStatus) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? String
    self.timer = aDecoder.decodeObject(forKey: SerializationKeys.timer) as? String
    self.bet365Id = aDecoder.decodeObject(forKey: SerializationKeys.bet365Id) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(score, forKey: SerializationKeys.score)
    aCoder.encode(gameId, forKey: SerializationKeys.gameId)
    aCoder.encode(away, forKey: SerializationKeys.away)
    aCoder.encode(league, forKey: SerializationKeys.league)
    aCoder.encode(home, forKey: SerializationKeys.home)
    aCoder.encode(timeStatus, forKey: SerializationKeys.timeStatus)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(timer, forKey: SerializationKeys.timer)
    aCoder.encode(bet365Id, forKey: SerializationKeys.bet365Id)
  }

}
