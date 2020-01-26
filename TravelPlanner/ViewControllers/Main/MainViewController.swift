//
//  MainViewController.swift
//  TravelPlanner
//
//  Created by Thanakorn Amnajsatit on 25/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var delegate: HomeViewControllerDelegate?
    
    var trips = [TripModel]()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadAllTrips()
    }
    
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func loadAllTrips() {
        self.spinner.startAnimating()
        FirebaseManager.root.collection(FirestoreKeys.travel_data).getDocuments { (querySnapshot, error) in
            guard error == nil else {
                fatalError("Error getting data from Firestore.")
            }
            guard let querySnapshot = querySnapshot else {
                fatalError("querySnapshot is nil")
            }
            for document in querySnapshot.documents {
                let trip = TripModel(data: document.data())
                FirebaseManager.storage.reference(withPath: trip.photo_path ?? "").getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                    guard error == nil else {
                        fatalError("Cannot download the picture.")
                    }
                    guard let data = data else { return }
                    
                    trip.image = UIImage(data: data)
                    self.trips.append(trip)
                    self.tableView.reloadData()
                }
            }
            
            self.spinner.stopAnimating()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.goToTripInfoVC(identifier: "TripInfoIdentifier", data: self.trips[indexPath.row])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tripCellIdentifier", for: indexPath) as? MainTableViewCell else {
            fatalError("The dequeued cell is not an instance of MainTableViewCell.")
        }
        cell.titleLabel.text = trips[indexPath.row].title
        cell.budgetLabel.text = "\(trips[indexPath.row].budget_start ?? "") ~ \(trips[indexPath.row].budget_end ?? "")"
        cell.airlineLabel.text = trips[indexPath.row].airline
        cell.hotelLabel.text = trips[indexPath.row].hotel
        cell.displayImage.image = trips[indexPath.row].image
        
        return cell
    }
    
    
}
