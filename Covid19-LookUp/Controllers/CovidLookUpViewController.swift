//
//  CovidLookUpViewController.swift
//  Covid19-LookUp
//
//  Created by Kary Martinez on 12/7/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class CovidLookUpViewController: UIViewController {
    
    lazy var tableView: UITableView = {
          // let tableView = UITableView(frame: UIScreen.main.bounds)
             let tableView = UITableView()
           tableView.register(CovidLookUPTableViewCell.self, forCellReuseIdentifier: "CountryCell")
           tableView.backgroundColor = .white
           tableView.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(tableView)
          // tableView.delegate = self
           tableView.dataSource = self
           return tableView

       }()
    private let apiClient = APIClient()
    
    private var countriesSummary = [CountrySummary]() {
      didSet { // property observer listens for changes on this property
        DispatchQueue.main.async { // we have to update UI on the main thread
          self.tableView.reloadData()
        }
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCovidData()

   
    }
    private func fetchCovidData() {
      apiClient.fetchCovidData { [weak self] (result) in
        switch result {
        case .failure(let error):
          print(error)
        case .success(let countries):
          self?.countriesSummary = countries
        }
      }
    }
      private func setTableViewConstraints() {
           NSLayoutConstraint.activate([
               tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
               tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
           ])
       }

}
extension CovidLookUpViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countriesSummary.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
    
    // configure cell
    let countrySummary = countriesSummary[indexPath.row]
    cell.textLabel?.text = countrySummary.country
    cell.detailTextLabel?.text = "Confirmed: \(countrySummary.totalConfirmed) Recovered: \(countrySummary.totalRecovered)"
    
    return cell
  }
}
