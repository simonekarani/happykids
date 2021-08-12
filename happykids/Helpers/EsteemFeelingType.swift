//
//  EsteemFeelingType.swift
//  happykids
//
//  Created by Simone Karani on 2/15/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation

public enum EsteemFeelingType: String, CaseIterable {
    
    case ANGRY = "Angry"
    case ANNOYED = "Annoyed"
    case BORED = "Bored"
    case EMBARRASSED = "Embarrassed"
    case JEALOUS = "Jealous"
    case HAPPY = "Happy"
    case NERVOUS = "Nervous"
    case SAD = "Sad"
    case SICK = "Sick"
    case STRESSED = "Stressed"
    case SURPRISED = "Surprised"
    case TIRED = "Tired"
    case WORRIED = "Worried"

    static var asArray: [EsteemFeelingType] {return self.allCases}
    
    static var esteemFeelingTypeDict: [String: Int] = [
        "Angry": 0,
        "Annoyed": 1,
        "Bored": 2,
        "Embarrassed": 3,
        "Jealous": 4,
        "Happy": 5,
        "Nervous": 6,
        "Sad": 7,
        "Sick": 8,
        "Stressed": 9,
        "Surprised": 10,
        "Tired": 11,
        "Worried": 12
    ];
    
    static func toInt(value:String) -> Int {
        return esteemFeelingTypeDict[value]!
    }
    
    var description: String {
        switch self {
        case .ANGRY: return "Angry"
        case .ANNOYED: return "Annoyed"
        case .BORED: return "Bored"
        case .EMBARRASSED: return "Embarrassed"
        case .JEALOUS: return "Jealous"
        case .HAPPY: return "Happy"
        case .NERVOUS: return "Nervous"
        case .SAD: return "Sad"
        case .SICK: return "Sick"
        case .STRESSED: return "Stressed"
        case .SURPRISED: return "Surprised"
        case .TIRED: return "Tired"
        case .WORRIED: return "Worried"
        }
    }
    
    init?(id : Int) {
        switch id {
        case 1:
            self = .ANGRY
        case 2:
            self = .ANNOYED
        case 3:
            self = .BORED
        case 4:
            self = .EMBARRASSED
        case 5:
            self = .JEALOUS
        case 6:
            self = .HAPPY
        case 7:
            self = .NERVOUS
        case 8:
            self = .SAD
        case 9:
            self = .SICK
        case 10:
            self = .STRESSED
        case 11:
            self = .SURPRISED
        case 12:
            self = .TIRED
        case 13:
            self = .WORRIED
        default:
            return nil
        }
    }
    
    func asInt() -> Int {
        return EsteemFeelingType.asArray.firstIndex(of: self)!
    }
}
