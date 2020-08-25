//
//  HistoryTableViewCell.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 17.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class HistoryTableCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let sizeOfLabelFont: CGFloat = 18
        static let sizeOfDescriptionFont: CGFloat = 12
        static let colorOfLabelText: UIColor = .black
        static let colorOfDescriptionText: UIColor = .gray
    }
    
    // MARK: - Properties
    
    private lazy var nameLabel: UILabel = {
        return configureLabel(font: Locals.sizeOfLabelFont, color: Locals.colorOfLabelText)
    }()
    
    private lazy var dateLabel: UILabel = {
        return configureLabel(font: Locals.sizeOfDescriptionFont, color: Locals.colorOfLabelText)
    }()
    
    private lazy var stackTitle: UIStackView = {
        let stackTitle = UIStackView()
        stackTitle.alignment = .center
        stackTitle.axis = .horizontal
        stackTitle.distribution = .equalCentering
        return stackTitle
    }()
    
    private lazy var descriptionLabel: UILabel = {
        return configureLabel(font: Locals.sizeOfDescriptionFont, color: Locals.colorOfDescriptionText)
    }()
    
    var viewModel: QueryViewModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackTitle)
        addSubview(descriptionLabel)
        stackTitle.addArrangedSubview(nameLabel)
        stackTitle.addArrangedSubview(dateLabel)
        
        stackTitle.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Lifecycle
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func updateContent(with viewModel: QueryViewModel) {
        nameLabel.text = viewModel.labelText
        dateLabel.text = viewModel.formattedDate
        descriptionLabel.text = viewModel.descriptionOfProperties
    }
    
}
