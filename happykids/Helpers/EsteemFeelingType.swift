//
//  EsteemFeelingType.swift
//  happykids
//
//  Created by Simone Karani on 2/15/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation

public enum EsteemFeelingType: String, CaseIterable {
    
    case ANGRY = "\u{1F621}   Angry"
    case ANNOYED = "\u{1F644}   Annoyed"
    case BORED = "\u{1F971}   Bored"
    case EMBARRASSED = "\u{1F633}   Embarrassed"
    case JEALOUS = "\u{1F47F}   Jealous"
    case HAPPY = "\u{1F601}   Happy"
    case NERVOUS = "\u{1F630}   Nervous"
    case SAD = "\u{1F61e}   Sad"
    case SICK = "\u{1F912}   Sick"
    case STRESSED = "\u{1F62c}   Stressed"
    case SURPRISED = "\u{1F62e}   Surprised"
    case TIRED = "\u{1F62b}   Tired"
    case WORRIED = "\u{1F61F}   Worried"

    static var asArray: [EsteemFeelingType] {return self.allCases}
    
    static var esteemFeelingTypeDict: [String: Int] = [
        "\u{1F621}Angry": 0,
        "\u{1F644}Annoyed": 1,
        "\u{1F971}Bored": 2,
        "\u{1F633}Embarrassed": 3,
        "\u{1F47F}Jealous": 4,
        "\u{1F601}Happy": 5,
        "\u{1F630}Nervous": 6,
        "\u{1F61e}Sad": 7,
        "\u{1F912}Sick": 8,
        "\u{1F62c}Stressed": 9,
        "\u{1F62e}Surprised": 10,
        "\u{1F62b}Tired": 11,
        "\u{1F61F}Worried": 12
    ];
    
    static func toInt(value:String) -> Int {
        return esteemFeelingTypeDict[value]!
    }
    
    var description: String {
        switch self {
        case .ANGRY: return "\u{1F621}   Angry"
        case .ANNOYED: return "\u{1F644}   Annoyed"
        case .BORED: return "\u{1F971}   Bored"
        case .EMBARRASSED: return "\u{1F633}   Embarrassed"
        case .JEALOUS: return "\u{1F47F}   Jealous"
        case .HAPPY: return "\u{1F601}   Happy"
        case .NERVOUS: return "\u{1F630}   Nervous"
        case .SAD: return "\u{1F61e}   Sad"
        case .SICK: return "\u{1F912}   Sick"
        case .STRESSED: return "\u{1F62c}   Stressed"
        case .SURPRISED: return "\u{1F62e}   Surprised"
        case .TIRED: return "\u{1F62b}   Tired"
        case .WORRIED: return "\u{1F61F}   Worried"
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
