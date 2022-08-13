//
//  TableViewController.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let data = DataLoader().cityData
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    // MARK: - placing data in cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dataForTable = data[indexPath.row]
        let id = String(dataForTable._id)
        let lat = String(dataForTable.coord.lat)
        let lon = String(dataForTable.coord.lat)
        cell.textLabel?.text = dataForTable.name + " " + id
        cell.detailTextLabel?.text = lat + " " + lon
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSeagway" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! MapViewController
                dvc.coord1 = data[indexPath.row].coord
                dvc.name = data[indexPath.row].name
                dvc.country = data[indexPath.row].country
            }
        }
    }
}
