//
//  FavoritesTableViewCell.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class FavoritesTableCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let sizeOfLabelFont: CGFloat = 18
        static let sizeOfDescriptionFont: CGFloat = 12
        static let colorOfLabelText: UIColor = .black
        static let colorOfDescriptionText: UIColor = .gray
    }
    
    // MARK: - Properties
    
    private var nameLabel: UILabel!
    private var dateLabel: UILabel!
    private var stackTitle: UIStackView!
    private var descriptionLabel: UILabel!
    
    var viewModel: Query? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = configureLabel(font: Locals.sizeOfLabelFont, color: Locals.colorOfLabelText)
        dateLabel = configureLabel(font: Locals.sizeOfDescriptionFont, color: Locals.colorOfLabelText)
        descriptionLabel = configureLabel(font: Locals.sizeOfDescriptionFont, color: Locals.colorOfDescriptionText)
        stackTitle = UIStackView()
        addSubview(stackTitle)
        addSubview(descriptionLabel)
        stackTitle.addArrangedSubview(nameLabel)
        stackTitle.addArrangedSubview(dateLabel)
        stackTitle.alignment = .center
        stackTitle.axis = .horizontal
        stackTitle.distribution = .equalCentering
        stackTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackTitle.topAnchor.constraint(equalTo: self.topAnchor),
            stackTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: stackTitle.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureLabel(font: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: font)
        label.textColor = color
        label.textAlignment = .left
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = self.bounds.width
        self.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Lifecycle
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func updateContent(with viewModel: Query) {
        nameLabel.text = viewModel.getLabelText()
        dateLabel.text = viewModel.getDate()
        descriptionLabel.text = viewModel.getDescription()
    }
    
}

