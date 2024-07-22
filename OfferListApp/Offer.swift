//
//  Offer.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import Foundation

struct Offer: Decodable {
    let offerName: String
    let description: String
    let endDate: String
    let offerAppImageUrl: String
    let tnc: String
}

