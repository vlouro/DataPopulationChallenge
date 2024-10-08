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
    var noDatalabel: UILabel?
    
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
        self.title = "Nation List"
        self.view.backgroundColor = .white
        self.nationCollectionView.delegate = self
        self.nationCollectionView.dataSource = self
        self.nationCollectionView.register(PopulationListViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(nationCollectionView)
        
        NSLayoutConstraint.activate([
            nationCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            nationCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            nationCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            nationCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    //MARK: Init ViewModel
    func initViewModel() {
        self.view.activityStartAnimating(activityColor: .black, backgroundColor: .black.withAlphaComponent(0.5))
        if viewModel.getNationData() == true {
            self.view.activityStopAnimating()
            let alert = UIAlertController(title: "Alert", message: "An error as occured loading the list, please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                self.initViewModel()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {_ in
                self.updateViewState()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.updateViewState()
                self?.view.activityStopAnimating()
                self?.nationCollectionView.reloadData()
            }
        }
    }
    
    //MARK: Update View State
    func updateViewState() {
        if viewModel.nationCellViewModels.count == 0 && self.noDatalabel == nil {
            self.noDatalabel = UILabel()
            self.noDatalabel?.text = "No data for population available"
            self.noDatalabel?.translatesAutoresizingMaskIntoConstraints = false
            self.noDatalabel?.textAlignment = .center
            guard let lblNoData = self.noDatalabel else {
                return
            }
            self.view.addSubview(lblNoData)
            
            NSLayoutConstraint.activate([
                lblNoData.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                lblNoData.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                lblNoData.heightAnchor.constraint(equalToConstant: 40),
                lblNoData.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-40)
            ])
            
            self.nationCollectionView.isHidden = true
        } else if self.noDatalabel != nil && viewModel.nationCellViewModels.count >= 1 {
            DispatchQueue.main.async {
                self.noDatalabel?.removeFromSuperview()
                self.nationCollectionView.isHidden = false
            }
        }
    }
    
}

//MARK: COLLECTIONVIEW DELEGATE
extension NationListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = nationCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! PopulationListViewCell
        cell.cellViewModel = self.viewModel.nationCellViewModels[indexPath.row]
        cell.layer.addBorder(edge: .bottom, color: .gray, thickness: 1)
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
    
}
