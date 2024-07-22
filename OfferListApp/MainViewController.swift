//
//  ViewController.swift
//  OfferListApp
//
//  Created by Icez on 22/7/2024.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var offers: [Offer] = []
    var sortedOffers: [Offer] = []
    let tableView = UITableView()
    var sortSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        fetchOffers()
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
        tableView.register(OfferCell.self, forCellReuseIdentifier: "OfferCell")
        tableView.separatorStyle = .none
        
        // Add the header view for sorting
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        sortSwitch.translatesAutoresizingMaskIntoConstraints = false
        sortSwitch.addTarget(self, action: #selector(toggleSort), for: .valueChanged)
        
        let label = UILabel()
        label.text = "Sort by expiry date"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(sortSwitch)
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            sortSwitch.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            sortSwitch.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        tableView.tableHeaderView = headerView
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        headerView.layoutIfNeeded() // Force layout to update the table header view height
    }
    
    private func setupNavigationBar() {
        title = "Offers List"
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 137/255, blue: 233/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        // Make sure the nav bar stays colored when scrolling
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 62/255, green: 137/255, blue: 233/255, alpha: 1)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    @objc private func toggleSort() {
        if sortSwitch.isOn {
            sortedOffers = offers.sorted { $0.endDate < $1.endDate }
        } else {
            sortedOffers = offers
        }
        tableView.reloadData()
    }
    
    private func fetchOffers() {
        NetworkManager.shared.fetchOffers { [weak self] offers in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.offers = offers ?? []
                self.sortedOffers = self.offers
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferCell
        let offer = sortedOffers[indexPath.row]
        cell.configure(with: offer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.offer = sortedOffers[indexPath.row]
        // Set an empty back button for the next view controller
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
