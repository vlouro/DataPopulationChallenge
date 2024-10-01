//
//  Nation.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation

typealias NationPopulation = [Nation]

// MARK: - Api Response
struct NationApiResponse: Codable {
    let data: [Nation]?
    let source : [Source]?
}

struct Nation : Codable {
    let idNation : String
    let nation : String
    let yearID : Int
    let year : String
    let population : Int
    let slugNation: String
    
    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case yearID = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
