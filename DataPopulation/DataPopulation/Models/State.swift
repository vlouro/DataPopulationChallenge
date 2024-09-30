//
//  State.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation

struct State : Codable {
    
    let idState : String
    let state : String
    let yearID : Int
    let year : String
    let population : Int
    let slugState: String
    
    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case yearID = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}

