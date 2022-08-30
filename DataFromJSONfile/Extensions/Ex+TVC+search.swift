//
//  extansions.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 16/08/2022.
//

import UIKit

extension TableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if segmentControlOutlet.selectedSegmentIndex == 0 {
            getFilteredDataBinary(searchedText: searchBar.text ?? String())
            }
        if segmentControlOutlet.selectedSegmentIndex == 1 {
            getFilteredData(searchedText: searchBar.text ?? String())
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = String()
        if segmentControlOutlet.selectedSegmentIndex == 0 {
            getFilteredDataBinary()
            }
        if segmentControlOutlet.selectedSegmentIndex == 1 {
            getFilteredData()
        }
    }
}

