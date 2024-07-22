//
//  ViewController.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var offers: [Offer] = []
    let tableView = UITableView()
    var isSortedByExpiryDate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSortButton()
        fetchOffers()
    }
    
    private func setupSortButton() {
        let sortButton = UIBarButtonItem(title: "Sort by expiry date", style: .plain, target: self, action: #selector(toggleSort))
        navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc private func toggleSort() {
        isSortedByExpiryDate.toggle()
        if isSortedByExpiryDate {
            offers.sort { $0.endDate < $1.endDate }
        } else {
            // Implement default sort if needed
        }
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func fetchOffers() {
        NetworkManager.shared.fetchOffers { [weak self] offers in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.offers = offers ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let offer = offers[indexPath.row]
        cell.textLabel?.text = offer.offerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.offer = offers[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


