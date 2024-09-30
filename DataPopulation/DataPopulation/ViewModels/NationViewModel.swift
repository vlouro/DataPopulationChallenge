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
    func getNationData() {

        
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
    
    func getNationViewModel(at indexPath: IndexPath) -> PopulationListCellViewModel {
        return nationCellViewModels[indexPath.section]
    }
    
}
