//
//  Stats.swift
//
//  Created by VinMac on 09/06/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Stats: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let ballSafe = "ball_safe"
    static let onTarget = "on_target"
    static let offTarget = "off_target"
    static let dangerousAttacks = "dangerous_attacks"
    static let substitutions = "substitutions"
    static let goals = "goals"
    static let redcards = "redcards"
    static let yellowredCards = "yellowred_cards"
    static let penalties = "penalties"
    static let corners = "corners"
    static let cornerH = "corner_h"
    static let attacks = "attacks"
    static let cornerF = "corner_f"
    static let yellowcards = "yellowcards"
    static let injuries = "injuries"
    static let possessionRt = "possession_rt"
  }

  // MARK: Properties
  public var ballSafe: [String]?
  public var onTarget: [String]?
  public var offTarget: [String]?
  public var dangerousAttacks: [String]?
  public var substitutions: [String]?
  public var goals: [String]?
  public var redcards: [String]?
  public var yellowredCards: [String]?
  public var penalties: [String]?
  public var corners: [String]?
  public var cornerH: [String]?
  public var attacks: [String]?
  public var cornerF: [String]?
  public var yellowcards: [String]?
  public var injuries: [String]?
  public var possessionRt: [String]?

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
    if let items = json[SerializationKeys.ballSafe].array { ballSafe = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.onTarget].array { onTarget = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.offTarget].array { offTarget = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.dangerousAttacks].array { dangerousAttacks = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.substitutions].array { substitutions = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.goals].array { goals = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.redcards].array { redcards = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.yellowredCards].array { yellowredCards = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.penalties].array { penalties = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.corners].array { corners = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.cornerH].array { cornerH = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.attacks].array { attacks = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.cornerF].array { cornerF = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.yellowcards].array { yellowcards = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.injuries].array { injuries = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.possessionRt].array { possessionRt = items.map { $0.stringValue } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = ballSafe { dictionary[SerializationKeys.ballSafe] = value }
    if let value = onTarget { dictionary[SerializationKeys.onTarget] = value }
    if let value = offTarget { dictionary[SerializationKeys.offTarget] = value }
    if let value = dangerousAttacks { dictionary[SerializationKeys.dangerousAttacks] = value }
    if let value = substitutions { dictionary[SerializationKeys.substitutions] = value }
    if let value = goals { dictionary[SerializationKeys.goals] = value }
    if let value = redcards { dictionary[SerializationKeys.redcards] = value }
    if let value = yellowredCards { dictionary[SerializationKeys.yellowredCards] = value }
    if let value = penalties { dictionary[SerializationKeys.penalties] = value }
    if let value = corners { dictionary[SerializationKeys.corners] = value }
    if let value = cornerH { dictionary[SerializationKeys.cornerH] = value }
    if let value = attacks { dictionary[SerializationKeys.attacks] = value }
    if let value = cornerF { dictionary[SerializationKeys.cornerF] = value }
    if let value = yellowcards { dictionary[SerializationKeys.yellowcards] = value }
    if let value = injuries { dictionary[SerializationKeys.injuries] = value }
    if let value = possessionRt { dictionary[SerializationKeys.possessionRt] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.ballSafe = aDecoder.decodeObject(forKey: SerializationKeys.ballSafe) as? [String]
    self.onTarget = aDecoder.decodeObject(forKey: SerializationKeys.onTarget) as? [String]
    self.offTarget = aDecoder.decodeObject(forKey: SerializationKeys.offTarget) as? [String]
    self.dangerousAttacks = aDecoder.decodeObject(forKey: SerializationKeys.dangerousAttacks) as? [String]
    self.substitutions = aDecoder.decodeObject(forKey: SerializationKeys.substitutions) as? [String]
    self.goals = aDecoder.decodeObject(forKey: SerializationKeys.goals) as? [String]
    self.redcards = aDecoder.decodeObject(forKey: SerializationKeys.redcards) as? [String]
    self.yellowredCards = aDecoder.decodeObject(forKey: SerializationKeys.yellowredCards) as? [String]
    self.penalties = aDecoder.decodeObject(forKey: SerializationKeys.penalties) as? [String]
    self.corners = aDecoder.decodeObject(forKey: SerializationKeys.corners) as? [String]
    self.cornerH = aDecoder.decodeObject(forKey: SerializationKeys.cornerH) as? [String]
    self.attacks = aDecoder.decodeObject(forKey: SerializationKeys.attacks) as? [String]
    self.cornerF = aDecoder.decodeObject(forKey: SerializationKeys.cornerF) as? [String]
    self.yellowcards = aDecoder.decodeObject(forKey: SerializationKeys.yellowcards) as? [String]
    self.injuries = aDecoder.decodeObject(forKey: SerializationKeys.injuries) as? [String]
    self.possessionRt = aDecoder.decodeObject(forKey: SerializationKeys.possessionRt) as? [String]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(ballSafe, forKey: SerializationKeys.ballSafe)
    aCoder.encode(onTarget, forKey: SerializationKeys.onTarget)
    aCoder.encode(offTarget, forKey: SerializationKeys.offTarget)
    aCoder.encode(dangerousAttacks, forKey: SerializationKeys.dangerousAttacks)
    aCoder.encode(substitutions, forKey: SerializationKeys.substitutions)
    aCoder.encode(goals, forKey: SerializationKeys.goals)
    aCoder.encode(redcards, forKey: SerializationKeys.redcards)
    aCoder.encode(yellowredCards, forKey: SerializationKeys.yellowredCards)
    aCoder.encode(penalties, forKey: SerializationKeys.penalties)
    aCoder.encode(corners, forKey: SerializationKeys.corners)
    aCoder.encode(cornerH, forKey: SerializationKeys.cornerH)
    aCoder.encode(attacks, forKey: SerializationKeys.attacks)
    aCoder.encode(cornerF, forKey: SerializationKeys.cornerF)
    aCoder.encode(yellowcards, forKey: SerializationKeys.yellowcards)
    aCoder.encode(injuries, forKey: SerializationKeys.injuries)
    aCoder.encode(possessionRt, forKey: SerializationKeys.possessionRt)
  }

}
