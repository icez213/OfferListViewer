//
//  DetailViewController.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var offer: Offer?
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
        view.addSubview(offerNameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(endDateLabel)
        view.addSubview(imageView)
        view.addSubview(tncLabel)
        
        // Setup layout constraints (omitted for brevity)
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
