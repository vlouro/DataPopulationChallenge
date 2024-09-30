//
//  NationListViewController.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation
import UIKit

class NationListViewController: UIViewController {
    
    let cellIdentifier = "NationListCollectionViewCell"
    
    let nationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceVertical = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var viewModel = {
        NationViewModel()
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
        self.title = "NationList"
        self.view.backgroundColor = .white
        self.nationCollectionView.delegate = self
        self.nationCollectionView.dataSource = self
        self.nationCollectionView.register(UINib(nibName: "NationListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(nationCollectionView)
        
        NSLayoutConstraint.activate([
            nationCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            nationCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            nationCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            nationCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func initViewModel() {
        
        viewModel.getNationData()
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.nationCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: COLLECTIONVIEW DELEGATE
extension NationListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = nationCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! PopulationListViewCell
            return cell
    }
    
}

//MARK: COLLECTIONVIEW DATA SOURCE
extension NationListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nationCellViewModels.count
    }
}

//MARK: COLLECTIONVIEW DELEGATEFLOWLAYOUT
extension NationListViewController: UICollectionViewDelegateFlowLayout {
    
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
