//
//  TableViewController.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let data = DataLoader().cityData
    var filteredData = [CityData]()
    let searchBarController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarUI()
        getFilteredData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    // MARK: - placing data in cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dataForTable = filteredData[indexPath.row]
        let country = String(dataForTable.country)
        let lat = String(dataForTable.coord.lat)
        let lon = String(dataForTable.coord.lat)
        cell.textLabel?.text = dataForTable.name + " " + country
        cell.detailTextLabel?.text = lat + " " + lon
        return cell
    }
    // MARK: - segue data in MapViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSeagway" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let mvc = segue.destination as? MapViewController else { return }
                mvc.coord = filteredData[indexPath.row].coord
                mvc.name = filteredData[indexPath.row].name
                mvc.id = filteredData[indexPath.row].id
            }
        }
    }
    // MARK: - searchbar configuration
    
    func setSearchBarUI() {
        searchBarController.searchBar.delegate = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.sizeToFit()
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    // MARK: - search logic configuration
    
    func getFilteredData(searchedText: String = String()) {
        let filteredListData: [CityData] = data.filter({ (object) -> Bool in
            searchedText.isEmpty ? true : object.name.contains(searchedText)
        })
        filteredData = filteredListData
        tableView.reloadData()
    }
    // MARK: - Binary search logic configuration
    
}
