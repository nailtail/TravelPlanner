//
//  TripInfoViewController.swift
//  TravelPlanner
//
//  Created by Thanakorn Amnajsatit on 26/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import UIKit

class TripInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var airlineLabel: UILabel!
    @IBOutlet weak var hotelLabel: UILabel!
    @IBOutlet weak var pointOfInterestLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    var trip: TripModel?

    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTripToViews()
    }
    
    func setupTripToViews() {
        self.titleLabel.text = trip?.title
        self.imgView.image = trip?.image
        self.descriptionTextView.text = trip?.description
        self.airlineLabel.text = trip?.airline
        self.hotelLabel.text = trip?.hotel
        self.pointOfInterestLabel.text = trip?.point_of_interest
        self.budgetLabel.text = "\(trip?.budget_start ?? "") ~ \(trip?.budget_end ?? "") Bath"
        self.scheduleLabel.text = "\(trip?.schedule_since ?? "") ~ \(trip?.schedule_until ?? "")"
    }
    

}
