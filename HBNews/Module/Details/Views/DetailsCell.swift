//
//  DetailsCell.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//
import Kingfisher
import UIKit

protocol DetailsCellInterface: AnyObject {
    func setNewsImageView(_ imageUrl: String)
    func setReadingListButtonTitle(_ text: String, isAdded: Bool)
    func setTitleLabel(_ text: String)
    func setDescriptionLabel(_ text: String)
    func vibrateForReadingList()
}

final class DetailsCell: UITableViewCell {

    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var readingListButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    var presenter: DetailsCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    @IBAction func addReadingListButtonTapped(_ sender: Any) {
        presenter.addReadingListButtonTapped()
    }
}

extension DetailsCell: DetailsCellInterface {
    func setNewsImageView(_ imageUrl: String) {
        let url = URL(string: imageUrl)
        let placeholder = UIImage(named: "no-image-available")
        newsImageView.kf.indicatorType = .activity
                
        newsImageView.kf.setImage(with: url) { result in
           switch result {
           case .failure(_):
                self.newsImageView.image = placeholder
           case .success(_):break
           }
         }
    }
    
    func setReadingListButtonTitle(_ text: String, isAdded: Bool) {
        readingListButton.titleLabel?.lineBreakMode = .byWordWrapping
        readingListButton.titleLabel?.textAlignment = .center
        readingListButton.setTitle(text, for: .normal)
    }
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    func setDescriptionLabel(_ text: String) {
        descriptionLabel.text = text
    }
    
    func vibrateForReadingList() {
        let tapticFeedback = UINotificationFeedbackGenerator()
        tapticFeedback.notificationOccurred(.success)
    }
}
