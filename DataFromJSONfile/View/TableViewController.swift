//
//  TableViewController.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import UIKit
import RxSwift

class TableViewController: UITableViewController {
    
    var data = DataLoader().cityData
    var filteredData = [CityData]()
    let searchBarController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarUI()
        getFilteredDataBinary(searchedText: "")
        
    }
    // MARK: - Table view data source
    
    @IBAction func selector(_ sender: UISegmentedControl) {
        switch segmentControlOutlet.selectedSegmentIndex {
        case 0:
            getFilteredDataBinary(searchedText: "")
        case 1:
            getFilteredData()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // MARK: - placing data in cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        let dataForTable = filteredData[indexPath.row]
        let country = String(dataForTable.country)
        let lat = String(dataForTable.coord.lat)
        let lon = String(dataForTable.coord.lat)
        tableViewCell.textLabel?.text = dataForTable.name + " " + country
        tableViewCell.detailTextLabel?.text = lat + " " + lon
        return tableViewCell
    }
    // MARK: - segue data in MapViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSeagway" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let mvc = segue.destination as? MapViewController else { return }
                mvc.city = filteredData[indexPath.row]
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
    
    // MARK: - filter search logic configuration
    
    func getFilteredData(searchedText: String = "") {
        let filteredListData: [CityData] = data.filter({ (object) -> Bool in
            searchedText.isEmpty ? true : object.name.contains(searchedText)
        })
        // можно ли это как-то вынести?
        filteredData = filteredListData
        tableView.reloadData()
    }
    
    // MARK: - Binary search logic configuration
    
    func getFilteredDataBinary(searchedText: String) {
        
//        var wordToFind: CityData = .init(country: "", name: "", id: 0, coord: .init(lon: 0.0, lat: 0.0))
//        var count = 0
//        var firstIndex = 0
//        var lastIndex = data.count
//
//        while firstIndex <= lastIndex {
//
//            count += 1
//            let middleIndex = (firstIndex + lastIndex) / 2
//            let middleValue = data[middleIndex]
//            if middleValue.name == searchedText {
//                wordToFind = middleValue
//                break
//            }
//            if searchedText.localizedCompare(middleValue.name) == ComparisonResult.orderedDescending {
//                firstIndex = middleIndex + 1
//            }
//            if searchedText.localizedCompare(middleValue.name) == ComparisonResult.orderedAscending {
//                lastIndex = middleIndex - 1
//            }
//        }
//        let filteredListData: [CityData] = data.filter({ (object) -> Bool in
//            wordToFind.name.isEmpty ? true : object.name.contains(wordToFind.name)
//        })
        
        guard !searchedText.isEmpty else {
            filteredData = data
            tableView.reloadData()
            return
        }
        
        var lowerBound = 0
        var upperBound = data.count
        var randomValidMidIndex: Int?
        
        while lowerBound < upperBound {
            let midIndex = lowerBound + (upperBound - lowerBound) / 2
            if data[midIndex].name.lowercased().hasPrefix(searchedText.lowercased()) {
                randomValidMidIndex = midIndex
                break
            } else if data[midIndex].name.lowercased() < searchedText.lowercased()  {
                lowerBound = midIndex + 1
            } else {
                upperBound = midIndex
            }
        }
        
        guard let midIndex = randomValidMidIndex else { return }
        
        var startIndex = midIndex
        var endIndex = midIndex
        
        while startIndex > -1, data[startIndex].name.lowercased().hasPrefix(searchedText.lowercased()) {
            startIndex -= 1
        }
        
        while endIndex < data.count, data[endIndex].name.lowercased().hasPrefix(searchedText.lowercased()) {
            endIndex += 1
        }
        
        filteredData = Array(data[(startIndex + 1)..<endIndex])
        tableView.reloadData()
    }
}
