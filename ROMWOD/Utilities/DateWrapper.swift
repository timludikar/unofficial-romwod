//
//  DateWrapper.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-03.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

fileprivate struct DateWrapper: Decodable {
    var date: Date
    
    private enum DateCodingKeys: String, CodingKey {
        case date
    }

    init(from decoder: Decoder) throws {
        let dateString: String
        
        if let container = try? decoder.container(keyedBy: DateCodingKeys.self) {
            dateString = try container.decode(String.self, forKey: .date)
        } else if let container = try? decoder.singleValueContainer() {
            dateString = try container.decode(String.self)
        } else {
            let decodingError = DecodingError.Context.init(codingPath: [DateCodingKeys.date], debugDescription: "Date is not valid format")
            throw DecodingError.dataCorrupted(decodingError)
        }
        
        switch dateString {
        case Regex("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3,4}Z"):
            self.date = Date.timestamp.date(from: dateString)!
        case Regex("\\d{4}-\\d{2}-\\d{1,2}"):
            self.date = Date.yyMMdd.date(from: dateString)!
        default:
            let decodingError = DecodingError.Context.init(codingPath: [DateCodingKeys.date], debugDescription: "Date is not valid format")
            throw DecodingError.dataCorrupted(decodingError)
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: Date.Type, forKey key: K) throws -> Date {
        return try self.decode(DateWrapper.self, forKey: key).date
    }
}
