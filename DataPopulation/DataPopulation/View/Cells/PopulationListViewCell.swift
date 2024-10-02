//
//  PopulationListViewCell.swift
//  DataPopulation
//
//  Created by Valter Louro on 01/10/2024.
//

import Foundation
import UIKit

class PopulationListViewCell : UICollectionViewCell {
    
    let informationContentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    let nationNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let populationNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellViewModel: PopulationListCellViewModel? {
        didSet {
            if let name = cellViewModel?.nation, let year = cellViewModel?.year, let populationNumber = cellViewModel?.population {
                nationNameLabel.text = "Nation: \(name)"
                yearLabel.text = "Year: \(year)"
                populationNumberLabel.text = "Population: \(populationNumber)"
            } else {
                nationNameLabel.text = "Unknown"
                yearLabel.text = "Unknown"
                populationNumberLabel.text = "Unknown"
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(informationContentView)
        informationContentView.addSubview(nationNameLabel)
        informationContentView.addSubview(yearLabel)
        informationContentView.addSubview(populationNumberLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            informationContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            informationContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            informationContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            informationContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nationNameLabel.leftAnchor.constraint(equalTo: informationContentView.leftAnchor),
            nationNameLabel.rightAnchor.constraint(equalTo: informationContentView.rightAnchor),
            nationNameLabel.topAnchor.constraint(equalTo: informationContentView.topAnchor, constant: 8),
            yearLabel.leadingAnchor.constraint(equalTo: informationContentView.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: informationContentView.trailingAnchor),
            yearLabel.topAnchor.constraint(equalTo: nationNameLabel.bottomAnchor, constant: 8),
            populationNumberLabel.leadingAnchor.constraint(equalTo: informationContentView.leadingAnchor),
            populationNumberLabel.trailingAnchor.constraint(equalTo: informationContentView.trailingAnchor),
            populationNumberLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8),
            populationNumberLabel.bottomAnchor.constraint(equalTo: informationContentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nationNameLabel.text = nil
        yearLabel.text = nil
        populationNumberLabel.text = nil
    }
}
