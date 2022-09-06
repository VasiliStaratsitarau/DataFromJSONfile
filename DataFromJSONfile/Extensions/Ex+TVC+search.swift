//
//  extensions.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 16/08/2022.
//

import UIKit

extension TableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if segmentControlOutlet.selectedSegmentIndex == 0 {
            getFilteredDataBinary(searchedText: searchBar.text ?? "")
        }
        if segmentControlOutlet.selectedSegmentIndex == 1 {
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
}

