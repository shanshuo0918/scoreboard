//
//  Score.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 3/28/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

public class Match: NSObject, NSCoding {
    public var matchID: String
    
    public let playerA: String
    public let playerB: String
    public let AImage: String?
    public let BImage: String?
    public let type: Int
    public var setA: Int
    public var setB: Int
    public var gameA: Int
    public var gameB: Int
    public var scoreA: Int
    public var scoreB: Int
    
    public var server: String
    
    public var currentServer: Int
    
    public var inTieBreak: Bool
    public var finalSet: Bool
    public var withAd: Bool
    public var numberOfSets: Int
    public var inSuperTieBreak: Bool
    public var points: [Point]
    public var sets: [String]
//    public var logs: [String]
    
    public var startTime: NSDate
    public var timeSpan: NSTimeInterval
    public var completed: Bool
    public var winner: Int
    
    
    required public init(coder decoder: NSCoder)
    {
        matchID = decoder.decodeObjectForKey("matchID") as! String
        playerA = decoder.decodeObjectForKey("playerA") as! String
        playerB = decoder.decodeObjectForKey("playerB") as! String
        AImage = decoder.decodeObjectForKey("AImage") as? String
        BImage = decoder.decodeObjectForKey("BImage") as? String
    
        type = decoder.decodeIntegerForKey("type")
        setA = decoder.decodeIntegerForKey("setA")
        setB = decoder.decodeIntegerForKey("setB")
        gameA = decoder.decodeIntegerForKey("gameA")
        gameB = decoder.decodeIntegerForKey("gameB")
        
        scoreA = decoder.decodeIntegerForKey("scoreA")
        scoreB = decoder.decodeIntegerForKey("scoreB")
        
        server = decoder.decodeObjectForKey("server") as! String
        currentServer = decoder.decodeIntegerForKey("currentServer")
        
        inTieBreak = decoder.decodeBoolForKey("inTieBreak")
        finalSet = decoder.decodeBoolForKey("finalSet")
        withAd = decoder.decodeBoolForKey("withAd")
        numberOfSets = decoder.decodeIntegerForKey("numberOfSets")
        inSuperTieBreak = decoder.decodeBoolForKey("inSuperTieBreak")
        points = decoder.decodeObjectForKey("points") as! [Point]
//        logs = decoder.decodeObjectForKey("logs") as! [String]
        sets = decoder.decodeObjectForKey("sets") as! [String]
        startTime = decoder.decodeObjectForKey("startTime") as! NSDate
        timeSpan = decoder.decodeDoubleForKey("timeSpan")
        completed = decoder.decodeBoolForKey("completed")
        winner = decoder.decodeIntegerForKey("winner")
    }
    
    public func encodeWithCoder(encoder: NSCoder)
    {
        encoder.encodeObject(matchID, forKey: "matchID")
        encoder.encodeObject(playerA, forKey: "playerA")
        encoder.encodeObject(playerB, forKey: "playerB")
        encoder.encodeObject(AImage, forKey: "AImage")
        encoder.encodeObject(BImage, forKey: "BImage")
        
        encoder.encodeInteger(type, forKey: "type")
        encoder.encodeInteger(setA, forKey: "setA")
        encoder.encodeInteger(setB, forKey: "setB")
        encoder.encodeInteger(gameA, forKey: "gameA")
        encoder.encodeInteger(gameB, forKey: "gameB")
        
        encoder.encodeInteger(scoreA, forKey: "scoreA")
        encoder.encodeInteger(scoreB, forKey: "scoreB")
        encoder.encodeObject(server, forKey: "server")
        encoder.encodeInteger(currentServer, forKey: "currentServer")
        encoder.encodeBool(inTieBreak, forKey: "inTieBreak")
        
        encoder.encodeInteger(numberOfSets, forKey: "numberOfSets")
        encoder.encodeBool(finalSet, forKey: "fianlSet")
        encoder.encodeBool(withAd, forKey: "withAd")
        encoder.encodeObject(points, forKey: "points")
        encoder.encodeBool(inSuperTieBreak, forKey: "inSuperTieBreak")
        
//        encoder.encodeObject(logs, forKey: "logs")
        encoder.encodeObject(sets, forKey: "sets")
        encoder.encodeObject(startTime, forKey: "startTime")
        encoder.encodeDouble(timeSpan, forKey: "timeSpan")
        encoder.encodeBool(completed, forKey: "completed")
        encoder.encodeInteger(winner, forKey: "winner")
    }
    
    
    init?(playerA: String, playerB: String, AImage: String?, BImage: String?, server: Int, type: Int)
    {
        self.matchID = NSUUID().UUIDString
        self.playerA = playerA
        self.playerB = playerB
        self.AImage = AImage
        self.BImage = BImage
        
        self.type = type
        self.setA = 0
        self.setB = 0
        self.gameA = 0
        self.gameB = 0
        self.scoreA = 0
        self.scoreB = 0
        self.inTieBreak = false
        if server == 0 {
            self.server = playerA
        } else {
            self.server = playerB
        }
        
        self.currentServer = server
        self.points = []
//        self.logs = []
        self.sets = []
        if type % 2 == 0 {
            self.withAd = false
        } else {
            self.withAd = true
        }
        if type < 8 {
            self.finalSet = true
        } else {
            self.finalSet = false
        }
        inSuperTieBreak = false
        if finalSet && (type % 8 == 0 || type % 8 == 1) {
            inSuperTieBreak = true
        }
        self.numberOfSets = type / 8 + 1
        self.startTime = NSDate()
        self.timeSpan = 0
        self.completed = false
        self.winner = -1
    }
    
    func isComplete() -> Bool {
        return completed
    }
    
    func getASet() -> String {
        return "\(setA)"
    }
    
    func getBSet() -> String {
        return "\(setB)"
    }
    
    func getAGame() -> String {
        return "\(gameA)"
    }
    
    func getBGame() -> String {
        return "\(gameB)"
    }
    
    func getAScore() -> String {
        if inTieBreak || inSuperTieBreak {
            return "\(scoreA)"
        }
        
        switch scoreA
        {
        case 0:
            return "00"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "AD"
        default:
            return "ER"
        }
    }
    
    func getBScore() -> String {
        if inTieBreak || inSuperTieBreak {
            return "\(scoreB)"
        }
        
        switch scoreB
        {
        case 0:
            return "00"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "AD"
        default:
            return "ER"
        }
    }
    
    func AWin()
    {
        points.last?.log += playerA
        points.last?.log += " WON the Match. "
//        logs.append(playerA + " won the Match")
        self.completed = true
        self.winner = 0
        let currentTime = NSDate()
        self.timeSpan = currentTime.timeIntervalSinceDate(startTime)
    }
    
    func AGetSet()
    {
        points.last?.log += playerA
        points.last?.log += " WON the Set. "
//        logs.append(playerA + " won the set")
        sets.append("\(getAGame())-\(getBGame())")
        setA = setA + 1
        if setA == numberOfSets {
            AWin()
        } else if setA == numberOfSets - 1  && setB == numberOfSets - 1 {
            finalSet = true
            if type % 8 == 0 || type % 8 == 1 {
                inSuperTieBreak = true
            }
        }
    }
    
    func AGetGame()
    {
        points.last?.log += playerA
        points.last?.log += " WON the Game. "
//        logs.append(playerA + " won the game")
        gameA = gameA + 1
        currentServer = 1 - currentServer
        let oldScoreA = scoreA
        let oldScoreB = scoreB
        scoreA = 0
        scoreB = 0
        
        // final set adv set
        if inSuperTieBreak {
            BGetSet()
            gameA = oldScoreA
            gameB = oldScoreB
        } else if finalSet && (type % 8 == 4 || type % 8 == 5) {
            if gameA >= 6 && gameA - gameB >= 2 {
                AGetSet()
                gameA = 0
                gameB = 0
            }
        } else {
            // check if a set has end
            if gameA == 6 {
                if gameB <= 4 {
                    AGetSet()
                    gameA = 0
                    gameB = 0
                } else if gameB == 6 {
                    inTieBreak = true
                }
            } else if gameA == 7 {
                AGetSet()
                gameA = 0
                gameB = 0
                inTieBreak = false
            }
        }
        
        
    }
    
    func AGetPoint()
    {
//        logs.append(playerA + " won the point")
        let point: Point = Point(currentMatch: self, winner: 0)
        points.append(point)
        points.last?.log = playerA + " WON the Point. "
        
        scoreA = scoreA + 1
        
        if inSuperTieBreak {
            if scoreA >= 10 && scoreA - scoreB >= 2 {
                AGetGame()
            } else if (scoreA + scoreB) % 2 == 1 {
                currentServer = 1 - currentServer
            }
        } else if inTieBreak {
            if scoreA >= 7 && scoreA - scoreB >= 2 {
                AGetGame()
            } else if (scoreA + scoreB) % 2 == 1 {
                currentServer = 1 - currentServer
            }
        } else {
            // check if a game end
            if scoreA == 4 {
                if !withAd {
                    AGetGame()
                }
                // 45:0, 45:15, 45:30
                else if scoreB <= 2 {
                    AGetGame()
                }
                    // back to deuce
                else if scoreB == 4 {
                    scoreA = 3
                    scoreB = 3
                }
            } else if scoreA == 5 {
                AGetGame()
            }
        }
        points.last?.addSocreDisplay(self)
        
    }
    
    func BWin()
    {
        points.last?.log += playerB
        points.last?.log += " WON the Match. "
//        logs.append(playerB + " won the Match")
        self.completed = true
        self.winner = 1
        let currentTime = NSDate()
        self.timeSpan = currentTime.timeIntervalSinceDate(startTime)
    }
    
    func BGetSet()
    {
        points.last?.log += playerB
        points.last?.log += " WON the Set. "
//        logs.append(playerB + " won the set")
        sets.append("\(getAGame())-\(getBGame())")
        setB = setB + 1
        if setB == numberOfSets {
            BWin()
        } else if setA == numberOfSets - 1  && setB == numberOfSets - 1 {
            finalSet = true
            if type % 8 == 0 || type % 8 == 1 {
                inSuperTieBreak = true
            }
        }
    }
    
    func BGetGame()
    {
        points.last?.log += playerB
        points.last?.log += " WON the Game. "
//        logs.append(playerB + " won the game")
        gameB = gameB + 1
        currentServer = 1 - currentServer
        let oldScoreA = scoreA
        let oldScoreB = scoreB
        scoreA = 0
        scoreB = 0
        
        // final set adv set
        if inSuperTieBreak {
            BGetSet()
            gameA = scoreA
            gameB = scoreB
        } else if finalSet && (type % 8 == 4 || type % 8 == 5) {
            if gameB >= 6 && gameB - gameA >= 2 {
                BGetSet()
                gameA = oldScoreA
                gameB = oldScoreB
            }
        } else {
            // check if a set has end
            if gameB == 6 {
                if gameA <= 4 {
                    BGetSet()
                    gameA = 0
                    gameB = 0
                } else if gameA == 6 {
                    inTieBreak = true
                }
            } else if gameB == 7 {
                BGetSet()
                gameA = 0
                gameB = 0
                inTieBreak = false
            }
        }
        
        
    }
    
    func BGetPoint()
    {
        let point: Point = Point(currentMatch: self, winner: 1)
        points.append(point)
        points.last?.log = playerB + " WON the Point. "
//        logs.append(playerB + " won the point")
        scoreB = scoreB + 1
        if inSuperTieBreak {
            
            if scoreB >= 10 && scoreB - scoreA >= 2 {
                BGetGame()
            } else if (scoreA + scoreB) % 2 == 1 {
                currentServer = 1 - currentServer
            }
        } else if inTieBreak {
            if scoreB >= 7 && scoreB - scoreA >= 2 {
                BGetGame()
            } else if (scoreA + scoreB) % 2 == 1 {
                currentServer = 1 - currentServer
            }
        } else {
            // check if a game end
            if scoreB == 4 {
                if !withAd {
                    BGetGame()
                }
                // 45:0, 45:15, 45:30
                else if scoreA <= 2 {
                    BGetGame()
                }
                    // back to deuce
                else if scoreA == 4 {
                    scoreA = 3
                    scoreB = 3
                }
            } else if scoreB == 5 {
                BGetGame()
            }
        }
        points.last?.addSocreDisplay(self)
        
    }
    
    func replayPoint() {
        if let lastPoint = self.points.last {
            // 
            if self.gameA == 0 && self.gameB == 0 && self.sets.count != 0 {
                self.sets.removeLast()
            }
            
            self.setA = lastPoint.setA
            self.setB = lastPoint.setB
            self.gameA = lastPoint.gameA
            self.gameB = lastPoint.gameB
            self.scoreA = lastPoint.scoreA
            self.scoreB = lastPoint.scoreB
            self.currentServer = lastPoint.server
            self.inTieBreak = lastPoint.inTieBreak
            self.inSuperTieBreak = lastPoint.inSuperTieBreak
            self.points.removeLast()
            //
            
            self.completed = false
            
        }
    }
    
    
    func getType() -> String
    {
        switch type
        {
        case 0:
            return "One Set With Super Tie Break No ADV"
        case 1:
            return "One Set With Super Tie Break With ADV"
        case 2:
            return "One Set Normal Set No ADV"
        case 3:
            return "One Set Normal Set With ADV"
        case 4:
            return "One Set Adv Set No ADV"
        case 5:
            return "One Set Adv Set With ADV"
            
        case 8:
            return "Three Set With Super Tie Break Final Set No ADV"
        case 9:
            return "Three Set With Super Tie Break Final Set With ADV"
        case 10:
            return "Three Set Normal Set Final Set No ADV"
        case 11:
            return "Three Set Normal Set Final Set With ADV"
        case 12:
            return "Three Set Adv Set Final Set No ADV"
        case 13:
            return "Three Set Adv Set Final Set With ADV"
            
        case 16:
            return "Five Set With Super Tie Break Final Set No ADV"
        case 17:
            return "Five Set With Super Tie Break Final Set With ADV"
        case 18:
            return "Five Set Normal Set Final Set No ADV"
        case 19:
            return "Five Set Normal Set Final Set With ADV"
        case 20:
            return "Five Set Adv Set Final Set No ADV"
        case 21:
            return "Five Set Adv Set Final Set With ADV"
            
        default:
            return "No Type"
        }
    }

    
}

public class Point: NSObject, NSCoding {
    public var setA: Int
    public var setB: Int
    public var gameA: Int
    public var gameB: Int
    public var scoreA: Int
    public var scoreB: Int
    // 0 for A, 1 for B
    public var winner: Int
    public var scoreDisplay: String
    public var setDisplay: String
    public var log: String
    
    public var server: Int
    public var inTieBreak: Bool
    public var finalSet: Bool
    public var inSuperTieBreak: Bool
    
    
    required public init(coder decoder: NSCoder)
    {
        setA = decoder.decodeIntegerForKey("setA")
        setB = decoder.decodeIntegerForKey("setB")
        gameA = decoder.decodeIntegerForKey("gameA")
        gameB = decoder.decodeIntegerForKey("gameB")
        scoreA = decoder.decodeIntegerForKey("scoreA")
        scoreB = decoder.decodeIntegerForKey("scoreB")
        winner = decoder.decodeIntegerForKey("winner")
        scoreDisplay = decoder.decodeObjectForKey("scoreDisplay") as! String
        setDisplay = decoder.decodeObjectForKey("setDisplay") as! String
        log = decoder.decodeObjectForKey("log") as! String
        
        server = decoder.decodeIntegerForKey("server")
        inTieBreak = decoder.decodeBoolForKey("inTieBreak")
        finalSet = decoder.decodeBoolForKey("finalSet")
        inSuperTieBreak = decoder.decodeBoolForKey("inSuperTieBreak")
        
    }
    
    public func encodeWithCoder(encoder: NSCoder)
    {
        encoder.encodeInteger(setA, forKey: "setA")
        encoder.encodeInteger(setB, forKey: "setB")
        encoder.encodeInteger(gameA, forKey: "gameA")
        encoder.encodeInteger(gameB, forKey: "gameB")
        encoder.encodeInteger(scoreA, forKey: "scoreA")
        encoder.encodeInteger(scoreB, forKey: "scoreB")
        encoder.encodeInteger(winner, forKey: "winner")
        encoder.encodeObject(scoreDisplay, forKey: "scoreDisplay")
        encoder.encodeObject(setDisplay, forKey: "setDisplay")
        encoder.encodeObject(log, forKey: "log")
        
        encoder.encodeInteger(server, forKey: "server")
        encoder.encodeBool(inTieBreak, forKey: "inTieBreak")
        encoder.encodeBool(inSuperTieBreak, forKey: "inSuperTieBreak")
        encoder.encodeBool(finalSet, forKey: "finalSet")
        
    }
    
    public func addSocreDisplay(currentMatch: Match) {
        self.scoreDisplay = "\(currentMatch.getAScore()) - \(currentMatch.getBScore())"
        var previousSet = ""
        println(currentMatch.sets.count)
        if currentMatch.sets.count != 0 {
            for singleSet in currentMatch.sets {
                previousSet += singleSet
                previousSet += " "
            }
        }
        if currentMatch.completed {
            self.setDisplay = previousSet
        } else {
            self.setDisplay = previousSet + "\(currentMatch.getAGame())-\(currentMatch.getBGame())"
        }
        
    }
    
    init(currentMatch: Match, winner: Int) {
        self.setA = currentMatch.setA
        self.setB = currentMatch.setB
        self.gameA = currentMatch.gameA
        self.gameB = currentMatch.gameB
        self.scoreA = currentMatch.scoreA
        self.scoreB = currentMatch.scoreB
        self.winner = winner
        self.scoreDisplay = ""
        self.setDisplay = ""
        self.log = ""
        self.finalSet = currentMatch.finalSet
        self.inSuperTieBreak = currentMatch.inSuperTieBreak
        self.inTieBreak = currentMatch.inTieBreak
        self.server = currentMatch.currentServer
    }
    
}


/*
    Type:
    case 0: One Set With Super Tie Break No ADV
    case 1: One Set With Super Tie Break With ADV
    case 2: One Set Normal Set No ADV
    case 3: One Set Normal Set With ADV
    case 4: One Set Adv Set No ADV
    case 5: One Set Adv Set With ADV

    case 8: Three Set With Super Tie Break Final Set No ADV
    case 9: Three Set With Super Tie Break Final Set With ADV
    case 10: Three Set Normal Set Final Set No ADV
    case 11: Three Set Normal Set Final Set With ADV
    case 12: Three Set Adv Set Final Set No ADV
    case 13: Three Set Adv Set Final Set With ADV

    case 16: Five Set With Super Tie Break Final Set No ADV
    case 17: Five Set With Super Tie Break Final Set With ADV
    case 18: Five Set Normal Set Final Set No ADV
    case 19: Five Set Normal Set Final Set With ADV
    case 20: Five Set Adv Set Final Set No ADV
    case 21: Five Set Adv Set Final Set With ADV

*/