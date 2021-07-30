//
//  SourcesCell.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import UIKit

protocol SourcesCellInterface: AnyObject {
    func setTitleLabel(_ text: String)
    func setDescriptionLabel(_ text: String)
}

class SourcesCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var presenter: SourcesCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
}

extension SourcesCell: SourcesCellInterface {
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    func setDescriptionLabel(_ text: String) {
        descriptionLabel.text = text
    }
}
