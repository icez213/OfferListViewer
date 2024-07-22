//
//  NetworkManager.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchOffers(completion: @escaping ([Offer]?) -> Void) {
        let urlString = "https://us-central1-anfield-project.cloudfunctions.net/offer-list"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let offers = try JSONDecoder().decode([Offer].self, from: data)
                completion(offers)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
