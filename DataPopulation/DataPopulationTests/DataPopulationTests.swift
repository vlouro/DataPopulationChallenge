//
//  DataPopulationTests.swift
//  DataPopulationTests
//
//  Created by Valter Louro on 30/09/2024.
//

import Testing
@testable import DataPopulation
import XCTest

class DataPopulationTests : XCTestCase {
    
    var nationVM: NationViewModel!
    var stateVM: StateViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        nationVM = NationViewModel(nationService: mockAPIService)
        stateVM = StateViewModel(stateService: mockAPIService)
    }
    
    override func tearDown() {
        super.tearDown()
        mockAPIService = nil
        nationVM = nil
        stateVM = nil
    }
    
    func test_fetch_nation() {
        var hasError = false
        var nationArr : [Nation] = []
        // Given
        mockAPIService.getPopulationNationList { result in
            switch result {
                
            case let .success(result):
                guard let nationDataResponse = result as? [Nation] else {
                    XCTFail("Failed to cast to [Nation]")
                    return
                }
                nationArr.append(contentsOf: nationDataResponse)
                break
            case .error(_):
                print("There was an error")
                hasError = true
            }
        }
    
        // Assert
        XCTAssert(nationArr.count > 0)
        XCTAssertFalse(hasError)
    }
    
    func test_fetch_state() {
        var hasError = false
        var stateArr : [State] = []
        // Given
        mockAPIService.getPopulationStateList { result in
            switch result {
                
            case let .success(result):
                guard let stateDataResponse = result as? [State] else {
                    XCTFail("Failed to cast to [State]")
                    return
                }
                stateArr.append(contentsOf: stateDataResponse)
                break
            case .error(_):
                print("There was an error")
                hasError = true
            }
        }
    
        // Assert
        XCTAssert(stateArr.count > 0)
        XCTAssertFalse(hasError)
    }
    
    func test_create_cell_view_model() {
        // Given
        let nationData = [Nation(idNation: "1", nation: "United Stated", yearID: 2022, year: "2022", population: 30000000, slugNation: "US")]
        
        for nation in nationData {
            nationVM.nationCellViewModels.append(nationVM.createPopulationCellModel(population: nation))
        }
        
        let stateData = [ State(idState: "1", state: "Alabama", yearID: 2022, year: "2022", population: 400000, slugState: "Alb")]
        
        for state in stateData {
            stateVM.stateCellViewModels.append(stateVM.createPopulationCellModel(population: state))
        }
        
        XCTAssert(nationVM.nationCellViewModels.count == nationData.count)
        XCTAssert(stateVM.stateCellViewModels.count == stateData.count)
    }
    
    func test_cell_nationViewModel() {
        //Given nation
        let nation = Nation(idNation: "1", nation: "United Stated", yearID: 2022, year: "2022", population: 30000000, slugNation: "US")
        
        // When creat cell view model
        let cellViewModel = nationVM.createPopulationCellModel(population: nation)
    
        // Assert the correctness of display information
        XCTAssertEqual(nation.nation, cellViewModel.nation)
        XCTAssertEqual(nation.year, cellViewModel.year)
        XCTAssertEqual(nation.population, cellViewModel.population)
    }
    
    func test_cell_stateViewModel() {
        //Given State
        let state = State(idState: "1", state: "Alabama", yearID: 2022, year: "2022", population: 400000, slugState: "Alb")
        
        // When creat cell view model
        let cellViewModel = stateVM.createPopulationCellModel(population: state)
    
        // Assert the correctness of display information
        XCTAssertEqual(state.state, cellViewModel.nation)
        XCTAssertEqual(state.year, cellViewModel.year)
        XCTAssertEqual(state.population, cellViewModel.population)
    }

}
