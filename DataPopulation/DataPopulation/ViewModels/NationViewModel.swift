//
//  NationViewModel.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation

class NationViewModel: NSObject {
    
    var reloadCollectionView: (() -> Void)?
    var nation = NationPopulation()
    
    var nationCellViewModels = [PopulationListCellViewModel]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    private var nationService: PopulationDataProtocol
    
    init(nationService: PopulationDataProtocol = NetworkRequests()) {
        self.nationService = nationService
    }
    
    //MARK: Get Nation Data
    func getNationData() -> Bool {
        var error = false
        NetworkRequests.shared.getPopulationNationList { result in
            switch result {
                
            case let .success(nationListResponse):
                guard let nationDataResponse =  nationListResponse as? NationApiResponse else {
                    return
                }
                
                self.decodeNationData(nationData: nationDataResponse)
                break
            case .error(_):
                print("There was an error")
                error = true
            }
        }
        return error
    }
    
    func decodeNationData(nationData: NationApiResponse) {
        guard let nationData = nationData.data, nationData.count > 0 else {
            return
        }
        
        var vms = [PopulationListCellViewModel]()
        
        for nation in nationData {
            vms.append(self.createPopulationCellModel(population: nation))
        }
        
        self.nationCellViewModels = vms
    }
    
    func createPopulationCellModel(population: Nation) -> PopulationListCellViewModel {
        
        let nation = population.nation
        let year = population.year
        let populationNumber = population.population
        return PopulationListCellViewModel(nation: nation, year: year, population: populationNumber)
    }
    
    func getNationViewModel(at indexPath: IndexPath) -> PopulationListCellViewModel {
        return nationCellViewModels[indexPath.section]
    }
    
}
