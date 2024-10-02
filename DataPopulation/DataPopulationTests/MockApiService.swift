//
//  MockApiService.swift
//  DataPopulationTests
//
//  Created by Valter Louro on 02/10/2024.
//

import Foundation
@testable import DataPopulation

class MockApiService: PopulationDataProtocol {
    
    var completeNation: [Nation] = [Nation]()
    var completeState: [State] = [State]()
    var isFetchDataCalled = false
    
    func getPopulationNationList(completionHandler: @escaping (DataPopulation.Result<(Any)>) -> Void) {
        let nation = Nation(idNation: "1", nation: "United Stated", yearID: 2022, year: "2022", population: 30000000, slugNation: "US")
        completeNation.append(nation)
        isFetchDataCalled = true
        completionHandler(.success(completeNation))
    }
    
    func getPopulationStateList(completionHandler: @escaping (DataPopulation.Result<(Any)>) -> Void) {
        let state = State(idState: "1", state: "Alabama", yearID: 2022, year: "2022", population: 400000, slugState: "Alb")
        completeState.append(state)
        isFetchDataCalled = true
        completionHandler(.success(completeState))
    }
    
}
