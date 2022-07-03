//
//  ClassGameDetails.swift
//
//  Created by VinMac on 09/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ClassGameDetails: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let time = "time"
    static let away = "away"
    static let league = "league"
    static let scores = "scores"
    static let home = "home"
    static let timeStatus = "time_status"
    static let stats = "stats"
    static let events = "events"
    static let ss = "ss"
    static let id = "id"
    static let inplayCreatedAt = "inplay_created_at"
    static let confirmedAt = "confirmed_at"
    static let sportId = "sport_id"
    static let extra = "extra"
    static let bet365Id = "bet365_id"
    static let inplayUpdatedAt = "inplay_updated_at"
    static let hasLineup = "has_lineup"
    static let timer = "timer"
  }

  // MARK: Properties
  public var time: String?
  public var away: Away?
  public var league: League?
//  public var scores: Scores?
  public var home: Home?
  public var timeStatus: String?
  public var stats: Stats?
  public var events: [Events]?
  public var ss: String?
  public var id: String?
  public var inplayCreatedAt: String?
  public var confirmedAt: String?
  public var sportId: String?
  public var extra: Extra?
  public var bet365Id: String?
  public var inplayUpdatedAt: String?
  public var hasLineup: Int?
  public var timer: Timer?

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
    time = json[SerializationKeys.time].string
    away = Away(json: json[SerializationKeys.away])
    league = League(json: json[SerializationKeys.league])
//    scores = Scores(json: json[SerializationKeys.scores])
    home = Home(json: json[SerializationKeys.home])
    timeStatus = json[SerializationKeys.timeStatus].string
    stats = Stats(json: json[SerializationKeys.stats])
    if let items = json[SerializationKeys.events].array { events = items.map { Events(json: $0) } }
    ss = json[SerializationKeys.ss].string
    id = json[SerializationKeys.id].string
    inplayCreatedAt = json[SerializationKeys.inplayCreatedAt].string
    confirmedAt = json[SerializationKeys.confirmedAt].string
    sportId = json[SerializationKeys.sportId].string
    extra = Extra(json: json[SerializationKeys.extra])
    bet365Id = json[SerializationKeys.bet365Id].string
    inplayUpdatedAt = json[SerializationKeys.inplayUpdatedAt].string
    hasLineup = json[SerializationKeys.hasLineup].int
    timer = Timer(json: json[SerializationKeys.timer])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = away { dictionary[SerializationKeys.away] = value.dictionaryRepresentation() }
    if let value = league { dictionary[SerializationKeys.league] = value.dictionaryRepresentation() }
//    if let value = scores { dictionary[SerializationKeys.scores] = value.dictionaryRepresentation() }
    if let value = home { dictionary[SerializationKeys.home] = value.dictionaryRepresentation() }
    if let value = timeStatus { dictionary[SerializationKeys.timeStatus] = value }
    if let value = stats { dictionary[SerializationKeys.stats] = value.dictionaryRepresentation() }
    if let value = events { dictionary[SerializationKeys.events] = value.map { $0.dictionaryRepresentation() } }
    if let value = ss { dictionary[SerializationKeys.ss] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = inplayCreatedAt { dictionary[SerializationKeys.inplayCreatedAt] = value }
    if let value = confirmedAt { dictionary[SerializationKeys.confirmedAt] = value }
    if let value = sportId { dictionary[SerializationKeys.sportId] = value }
    if let value = extra { dictionary[SerializationKeys.extra] = value.dictionaryRepresentation() }
    if let value = bet365Id { dictionary[SerializationKeys.bet365Id] = value }
    if let value = inplayUpdatedAt { dictionary[SerializationKeys.inplayUpdatedAt] = value }
    if let value = hasLineup { dictionary[SerializationKeys.hasLineup] = value }
    if let value = timer { dictionary[SerializationKeys.timer] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? String
    self.away = aDecoder.decodeObject(forKey: SerializationKeys.away) as? Away
    self.league = aDecoder.decodeObject(forKey: SerializationKeys.league) as? League
//    self.scores = aDecoder.decodeObject(forKey: SerializationKeys.scores) as? Scores
    self.home = aDecoder.decodeObject(forKey: SerializationKeys.home) as? Home
    self.timeStatus = aDecoder.decodeObject(forKey: SerializationKeys.timeStatus) as? String
    self.stats = aDecoder.decodeObject(forKey: SerializationKeys.stats) as? Stats
    self.events = aDecoder.decodeObject(forKey: SerializationKeys.events) as? [Events]
    self.ss = aDecoder.decodeObject(forKey: SerializationKeys.ss) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.inplayCreatedAt = aDecoder.decodeObject(forKey: SerializationKeys.inplayCreatedAt) as? String
    self.confirmedAt = aDecoder.decodeObject(forKey: SerializationKeys.confirmedAt) as? String
    self.sportId = aDecoder.decodeObject(forKey: SerializationKeys.sportId) as? String
    self.extra = aDecoder.decodeObject(forKey: SerializationKeys.extra) as? Extra
    self.bet365Id = aDecoder.decodeObject(forKey: SerializationKeys.bet365Id) as? String
    self.inplayUpdatedAt = aDecoder.decodeObject(forKey: SerializationKeys.inplayUpdatedAt) as? String
    self.hasLineup = aDecoder.decodeObject(forKey: SerializationKeys.hasLineup) as? Int
    self.timer = aDecoder.decodeObject(forKey: SerializationKeys.timer) as? Timer
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(away, forKey: SerializationKeys.away)
    aCoder.encode(league, forKey: SerializationKeys.league)
//    aCoder.encode(scores, forKey: SerializationKeys.scores)
    aCoder.encode(home, forKey: SerializationKeys.home)
    aCoder.encode(timeStatus, forKey: SerializationKeys.timeStatus)
    aCoder.encode(stats, forKey: SerializationKeys.stats)
    aCoder.encode(events, forKey: SerializationKeys.events)
    aCoder.encode(ss, forKey: SerializationKeys.ss)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(inplayCreatedAt, forKey: SerializationKeys.inplayCreatedAt)
    aCoder.encode(confirmedAt, forKey: SerializationKeys.confirmedAt)
    aCoder.encode(sportId, forKey: SerializationKeys.sportId)
    aCoder.encode(extra, forKey: SerializationKeys.extra)
    aCoder.encode(bet365Id, forKey: SerializationKeys.bet365Id)
    aCoder.encode(inplayUpdatedAt, forKey: SerializationKeys.inplayUpdatedAt)
    aCoder.encode(hasLineup, forKey: SerializationKeys.hasLineup)
    aCoder.encode(timer, forKey: SerializationKeys.timer)
  }

}
