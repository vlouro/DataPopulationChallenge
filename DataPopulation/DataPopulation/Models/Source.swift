//
//  Source.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation

struct Source : Codable {
    let measures : [String]
    let annotations: Annotation
    let name : String
    let substitutions: [String]?
}

struct Annotation : Codable {
    let sourceName: String
    let sourceDescription : String
    let datasetName: String
    let datasetLink: String
    let tableId: String
    let topic: String
    let subtopic: String
    
    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
        case datasetName = "dataset_name"
        case datasetLink = "dataset_link"
        case tableId = "table_id"
        case topic, subtopic
    }
}
