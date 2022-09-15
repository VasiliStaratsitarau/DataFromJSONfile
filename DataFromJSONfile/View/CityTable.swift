//
//  TableViewController.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import UIKit
import RxSwift
import PureLayout

class CityTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let cellID = "Cell"
    
    var data = DataLoader().cityData
    var filteredData = [CityData]()
    
    let searchBarController = UISearchController(searchResultsController: nil)
    var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addControl()
        setSearchBarUI()
        getFilteredDataBinary(searchedText: "")
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        self.tableView.register(myCell.self, forCellReuseIdentifier: cellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    // MARK: - Selector
    func addControl() {
        let segmentItems = ["Binary", "Filter"]
        segmentControl = UISegmentedControl(items: segmentItems)
        segmentControl.addTarget(self, action: #selector(selector(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        view.addSubview(segmentControl)
        navigationItem.titleView = segmentControl
    }
    
    @objc func selector(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            getFilteredDataBinary(searchedText: "")
        case 1:
            getFilteredData()
        default:
            break
        }
    }
    // MARK: - Table: view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Table: placing data in cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: myCell? = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? myCell
        if cell == nil {
            cell = myCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        }
        cell?.setUpCell()
        cell?.cityLabel.text = filteredData[indexPath.row].name + filteredData[indexPath.row].country
        cell?.coordLabel.text = String(filteredData[indexPath.row].coord.lat) + " " + String(filteredData[indexPath.row].coord.lon)
        return cell!
    }
    
    // MARK: - Table: sending data in MapViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC = MapViewController()
        mapVC.city = filteredData[indexPath.row]
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    // MARK: - searchbar configuration
    
    func setSearchBarUI() {
        searchBarController.searchBar.delegate = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.sizeToFit()
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - search logic: filter
    
    func getFilteredData(searchedText: String = "") {
        let filteredListData: [CityData] = data.filter({ (object) -> Bool in
            searchedText.isEmpty ? true : object.name.contains(searchedText)
        })
        // можно ли это как-то вынести?
        filteredData = filteredListData
        tableView.reloadData()
    }
    
    // MARK: - search logic: binary
    
    func getFilteredDataBinary(searchedText: String) {
        
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
