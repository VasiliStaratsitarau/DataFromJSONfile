//
//  extansions.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 16/08/2022.
//

import UIKit

extension TableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getFilteredDataBinary(searchedText: searchBar.text ?? String())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = String()
        getFilteredDataBinary()
    }
}

