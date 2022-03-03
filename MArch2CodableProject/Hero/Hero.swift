//
//  Hero.swift
//  MArch2CodableProject
//
//  Created by Consultant on 3/2/22.
//

import Foundation
struct Hero: Codable {
    let name: String
    let primaryAttribute: String
    let attackType:String
    let legs:Int
    let image:String
    
    //codable types can declare a special mested enumweraion named CodingKeys that conforms to the codigKeys protocol. When this enumeration is present it'scases serve
    enum CodingKeys: String, CodingKey {
        case name = "localized_name"
        case primaryAttribute = "primary_attr"
        case attackType = "attack_type"
        case legs = "legs"
        case image = "img"
    }

}
