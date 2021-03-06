//
//  trip.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 6..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class Trip {
    var name: String
    var status: tripStatus = .idle
    var member = [Member]()
    var history = [Record]()
    
    init(withName name: String = "default trip", with member: Member) {
        self.name = name
        self.member.append(member)
    }
}

extension Trip: Encodable {
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case member
        case history
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(member, forKey: .member)
        try container.encode(history.map(AnyRecord.init), forKey: .history)
    }
}
/*
extension Trip: Decodable {
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        member = try values.decode([Member].self, forKey: .member)
        var histories = try values.nestedContainer(keyedBy: recordType.self, forKey: .history)
        
        
    }
}
*/
enum tripStatus: String, Codable {
    case plan
    case traveling
    case idle
    case garbage
}

struct Member: Codable
{
    let name: String
    var address: String
}
