//
//  LocationViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 29/01/22.
//

import UIKit

class LocationViewController: UIViewController {

    
    //MARK: Properties
    let manager = LocationDataManager()
    var selectedCity: LocationItems?
    
    //MARK: IBOutlets, IBActions
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
    private func setCheckmark(for cell: UITableViewCell, location: LocationItems) {
        
        if selectedCity == location {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}


//MARK: Private Extension
private extension LocationViewController {
    func initialize() {
        manager.fetch()
    }
}

//MARK: UITableViewDataSource
extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return manager.numberOfSections()
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        
        let location = manager.locationItem(at: indexPath.row)
        cell.textLabel?.text = location.cityAndState
        setCheckmark(for: cell, location: location)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedCity = manager.locationItem(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
