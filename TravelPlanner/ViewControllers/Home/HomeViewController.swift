//
//  ViewController.swift
//  TravelPlanner
//
//  Created by Thanakorn Amnajsatit on 22/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import UIKit

class FromHomeSegue: UIStoryboardSegue {
    override func perform() {
        // Leave it empty for no animation
    }
}

protocol HomeViewControllerDelegate {
    func goToTripInfoVC(identifier: String, data: TripModel)
    func goToHomeVC(identifier: String)
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var travelAddingBtn: UIButton!
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        focusOnButton(buttonName: "Main")
        performSegue(withIdentifier: "MainIdentifier", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If it is the first time of performSegue(), add childVC and view to contentView
        if segue is FromHomeSegue {
            if segue.identifier == "MainIdentifier" {
                (segue.destination as! MainViewController).delegate = self
            }
            if segue.identifier == "TripInfoIdentifier" {
                (segue.destination as! TripInfoViewController).trip = sender as? TripModel
            }
            if segue.identifier == "TravelAddingIdentifier" {
                (segue.destination as! TravelAddingViewController).delegate = self
            }
            if children.count == 0 {
                segue.destination.view.frame = contentView.bounds
                segue.destination.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
                self.addChild(segue.destination)
                segue.destination.view.frame = contentView.bounds
                self.contentView.addSubview(segue.destination.view)
                segue.destination.didMove(toParent: self)

            // If there is already a child, swap it with the segue's destination view controller.
            } else {

                let oldViewController = self.children[0]
                segue.destination.view.frame = oldViewController.view.frame
                oldViewController.willMove(toParent: nil)
                self.addChild(segue.destination)
                self.transition(from: oldViewController, to: segue.destination, duration: 0, options: .transitionCrossDissolve, animations: nil) { completed in
                    oldViewController.removeFromParent()
                    segue.destination.didMove(toParent: self)
                }
            }
        }
    }
    
    func focusOnButton(buttonName: String) {
        // Set all buttons to default
        self.homeBtn.setImage(UIImage(named: "home"), for: .normal)
        self.travelAddingBtn.setImage(UIImage(named: "add-button"), for: .normal)
        
        switch buttonName {
        case "Main":
            self.homeBtn.setImage(UIImage(named: "home_pressed"), for: .normal)
        case "TravelAdding":
            self.travelAddingBtn.setImage(UIImage(named: "add-button_pressed"), for: .normal)
        default:
            break
        }
    }
    
    // MARK: - UIActions
    
    @IBAction func mainVCBtnTapped(_ sender: UIButton) {
        focusOnButton(buttonName: "Main")
        performSegue(withIdentifier: "MainIdentifier", sender: nil)
    }
    
    @IBAction func travelAddingBtnTapped(_ sender: UIButton) {
        focusOnButton(buttonName: "TravelAdding")
        performSegue(withIdentifier: "TravelAddingIdentifier", sender: nil)
    }
    
}

extension HomeViewController: HomeViewControllerDelegate {
    func goToHomeVC(identifier: String) {
        focusOnButton(buttonName: "Main")
        performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func goToTripInfoVC(identifier: String, data: TripModel) {
        focusOnButton(buttonName: "TripInfo")
        performSegue(withIdentifier: identifier, sender: data)
    }
}

