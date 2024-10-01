//
//  StateListViewController.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation
import UIKit

import Foundation
import UIKit

class StateListViewController: UIViewController {
    
    let cellIdentifier = "StateListCollectionViewCell"
    
    let stateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceVertical = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var viewModel = {
        StateViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupNavigationBarLayout()
        self.setupViews()
        self.initViewModel()
    }
    
    
    //MARK: SETUP NAVIGATION BAR LAYOUT
    func setupNavigationBarLayout() {
        navigationController?.appearanceNavigation()
    }
    
    //MARK: SETUP VIEW
    func setupViews() {
        self.title = "State List"
        self.view.backgroundColor = .white
        self.stateCollectionView.delegate = self
        self.stateCollectionView.dataSource = self
        self.stateCollectionView.register(PopulationListViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(stateCollectionView)
        
        NSLayoutConstraint.activate([
            stateCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            stateCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            stateCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            stateCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func initViewModel() {
        
        viewModel.getStateData()
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.stateCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: COLLECTIONVIEW DELEGATE
extension StateListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = stateCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! PopulationListViewCell
        cell.cellViewModel = self.viewModel.stateCellViewModels[indexPath.row]
        cell.layer.addBorder(edge: .bottom, color: .gray, thickness: 1)
        return cell
    }
    
}

//MARK: COLLECTIONVIEW DATA SOURCE
extension StateListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stateCellViewModels.count
    }
}

//MARK: COLLECTIONVIEW DELEGATEFLOWLAYOUT
extension StateListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = CGFloat(UIScreen.main.bounds.size.width)
            let height = CGFloat(100)
            
            return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
