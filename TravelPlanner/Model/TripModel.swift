//
//  TripModel.swift
//  TravelPlanner
//
//  Created by Thanakorn Amnajsatit on 25/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import Foundation
import UIKit

class TripModel {
    var title: String?
    var description: String?
    var airline: String?
    var hotel: String?
    var point_of_interest: String?
    var budget_start: String?
    var budget_end: String?
    var schedule_since: String?
    var schedule_until: String?
    var photo_path: String?
    var image: UIImage?
    
    init(data: [String: Any]) {
        title = data["title"] as? String ?? ""
        description = data["description"] as? String ?? ""
        airline = data["airline"] as? String ?? ""
        hotel = data["hotel"] as? String ?? ""
        point_of_interest = data["point_of_interest"] as? String ?? ""
        budget_start = data["budget_start"] as? String ?? ""
        budget_end = data["budget_end"] as? String ?? ""
        schedule_since = data["schedule_since"] as? String ?? ""
        schedule_until = data["schedule_until"] as? String ?? ""
        photo_path = data["photo_path"] as? String ?? ""
    }
}
