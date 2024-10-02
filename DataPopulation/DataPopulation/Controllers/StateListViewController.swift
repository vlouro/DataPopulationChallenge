//
//  StateListViewController.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//
import Foundation
import UIKit

class StateListViewController: UIViewController {
    
    let cellIdentifier = "StateListCollectionViewCell"
    var noDatalabel: UILabel?
    
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
    
    //MARK: Init ViewModel
    func initViewModel() {
        self.view.activityStartAnimating(activityColor: .black, backgroundColor: .black.withAlphaComponent(0.5))
        if viewModel.getStateData() == true {
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
                self?.stateCollectionView.reloadData()
            }
        }
    }
    
    //MARK: Update View State
    func updateViewState() {
        if viewModel.stateCellViewModels.count == 0 && self.noDatalabel == nil {
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
            
            self.stateCollectionView.isHidden = true
        } else if self.noDatalabel != nil && viewModel.stateCellViewModels.count >= 1 {
            DispatchQueue.main.async {
                self.noDatalabel?.removeFromSuperview()
                self.stateCollectionView.isHidden = false
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
    
}
