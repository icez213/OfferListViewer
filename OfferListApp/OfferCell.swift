//
//  OfferCell.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import UIKit

class OfferCell: UITableViewCell {
    
    let offerImageView = UIImageView()
    let offerNameLabel = UILabel()
    let cardView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardView()
        setupOfferImageView()
        setupOfferNameLabel()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCardView() {
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupOfferImageView() {
        cardView.addSubview(offerImageView)
        offerImageView.translatesAutoresizingMaskIntoConstraints = false
        offerImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            offerImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            offerImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            offerImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            offerImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupOfferNameLabel() {
        cardView.addSubview(offerNameLabel)
        offerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        offerNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        offerNameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            offerNameLabel.topAnchor.constraint(equalTo: offerImageView.bottomAnchor, constant: 8),
            offerNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            offerNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            offerNameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with offer: Offer) {
        offerNameLabel.text = offer.offerName
        if let url = URL(string: offer.offerAppImageUrl) {
            downloadImage(from: url)
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.offerImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
