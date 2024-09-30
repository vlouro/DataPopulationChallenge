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

        
            NetworkRequests.shared.getPopulationNationList { result in
                switch result {
                    
                case let .success(productList):
                    //self.decodeProducts(productsData: productList)
                    break
                case .error(_):
                    print("There was an error")
                }
            }
    }
    
    func decodeNationData(nationData: NationApiResponse) {
        
    }
    
    func createPopulationCellModel(product: Nation) -> PopulationListCellViewModel {
        
        var icon = ""
       
        return PopulationListCellViewModel(name: "")

    }
    
    func getStateViewModel(at indexPath: IndexPath) -> PopulationListCellViewModel {
        return stateCellViewModels[indexPath.section]
    }
    
}
