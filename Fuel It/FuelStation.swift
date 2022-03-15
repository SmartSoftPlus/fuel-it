//
//  FuelStation.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import PostgresNIO

class FuelStation: PostgresDecodable {
    required init<JSONDecoder>(from byteBuffer: inout ByteBuffer, type: PostgresDataType, format: PostgresFormat, context: PostgresDecodingContext<JSONDecoder>) throws where JSONDecoder : PostgresJSONDecoder {
        <#code#>
    }
    
    var id: Int?
    var brand: String?
    //Prices
    var pb95: Double?
    var pb98: Double?
    var oil: Double?
    var lpg: Double?
    var cng: Double?
    var electricity: Double?
    //
    var currency: String?
    var latitude: Double?
    var longitude: Double?
}
