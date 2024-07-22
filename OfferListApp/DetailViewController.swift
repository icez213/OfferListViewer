//
//  DetailViewController.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var offer: Offer?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let offerNameLabel = UILabel()
    let descriptionLabel = UILabel()
    let endDateLabel = UILabel()
    let imageView = UIImageView()
    let tncLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let offer = offer {
            displayOffer(offer)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [imageView, offerNameLabel, descriptionLabel, endDateLabel, tncLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        offerNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        offerNameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        endDateLabel.font = UIFont.systemFont(ofSize: 14)
        endDateLabel.textAlignment = .center
        tncLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            offerNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            offerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            offerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: offerNameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            endDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            endDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            endDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            tncLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 16),
            tncLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tncLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tncLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func displayOffer(_ offer: Offer) {
        offerNameLabel.text = offer.offerName
        descriptionLabel.text = offer.description
        endDateLabel.text = offer.endDate
        tncLabel.text = offer.tnc
        
        if let url = URL(string: offer.offerAppImageUrl) {
            downloadImage(from: url)
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
