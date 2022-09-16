//
//  extensions.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 16/08/2022.
//

import UIKit

extension CityTable: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if segmentControl.selectedSegmentIndex == 0 {
            getFilteredDataBinary(searchedText: searchBar.text ?? "")
        }
        if segmentControl.selectedSegmentIndex == 1 {
            getFilteredData(searchedText: searchBar.text ?? "")
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        getFilteredDataBinary(searchedText: "")
    }
    // MARK: - Search Logic: Filter
    func getFilteredData(searchedText: String = "") {
        let filteredListData: [CityData] = data.filter({ (object) -> Bool in
            searchedText.isEmpty ? true : object.name.contains(searchedText)
        })
        // можно ли это как-то вынести?
        filteredData = filteredListData
        tableView.reloadData()
    }
    // MARK: - Search Logic: Binary
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

