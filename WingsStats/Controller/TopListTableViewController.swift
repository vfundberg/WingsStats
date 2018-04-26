//
//  TopListTableViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

class TopListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    var searchResult : [String] = []
    var players : [String] = []
    var dataBase : DatabaseReference!
    
    var shouldUseSearchResult : Bool {
        if let t = searchController.searchBar.text {
            if t.isEmpty {
                return false
            }
        } else {
            return false
        }
        return searchController.isActive
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search for a specific player"
        definesPresentationContext = true
        dataBase = Database.database().reference()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        
        players = ["Victor Fundberg","Claudio Agus","Joakim Örneflo","Johannes Andersson","Jacob Henriksson","Alessandro Agus","Andreas Esmyr","Christoffer Strand","Adam Broberg","Peter Morer0","Tobias Bengston","Andreas Lundin","Pontus Vallin"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            searchResult = players.filter { $0.lowercased().contains(text.lowercased()) }
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return players.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if shouldUseSearchResult {
            let playerName = searchResult[indexPath.row]
            cell.textLabel?.text = playerName
        } else {
            let playerName = players[indexPath.row]
            cell.textLabel?.text = playerName
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
