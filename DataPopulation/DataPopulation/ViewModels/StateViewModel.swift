//
//  StateViewModel.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation

class StateViewModel: NSObject {
    
    var reloadCollectionView: (() -> Void)?
    var sate = StatePopulation()
    
    var stateCellViewModels = [PopulationListCellViewModel]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    private var stateService: PopulationDataProtocol
    
    init(stateService: PopulationDataProtocol = NetworkRequests()) {
        self.stateService = stateService
    }
    
    //MARK: Get State Data
    func getStateData() {
        NetworkRequests.shared.getPopulationStateList { result in
            switch result {
                
            case let .success(stateListResponse):
                guard let stateDataResponse =  stateListResponse as? StateApiResponse else {
                    return
                }
                
                self.decodeStateData(stateData: stateDataResponse)
                break
            case .error(_):
                print("There was an error")
            }
        }
    }
    
    func decodeStateData(stateData: StateApiResponse) {
        guard let stateData = stateData.data, stateData.count > 0 else {
            return
        }
        
        var vms = [PopulationListCellViewModel]()
        
        for state in stateData {
            vms.append(self.createPopulationCellModel(population: state))
        }
        
        self.stateCellViewModels = vms
    }
    
    func createPopulationCellModel(population: State) -> PopulationListCellViewModel {
        
        let nation = population.state
        let year = population.year
        let populationNumber = population.population
        
        return PopulationListCellViewModel(nation: nation, year: year, population: populationNumber)

    }
    
    func getStateViewModel(at indexPath: IndexPath) -> PopulationListCellViewModel {
        return stateCellViewModels[indexPath.section]
    }
    
}
