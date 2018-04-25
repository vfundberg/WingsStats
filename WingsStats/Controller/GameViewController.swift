//
//  GameViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit

class PlayerTableViewCell : UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
}


class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var team : Team = Team()
    var selectedIndexpath : [IndexPath] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlusStat(_ sender: Any) {
        selectedIndexpath = self.tableView.indexPathsForSelectedRows!
        for p in selectedIndexpath {
            let plusPlayer = team.playersInTeam[p.row]
            addPlusInGame(player: plusPlayer)
        }
        
        for p in selectedIndexpath {
            tableView.deselectRow(at: p, animated: true)
        }
        self.tableView.reloadData()
    }
    @IBAction func addMinusStat(_ sender: Any) {
        selectedIndexpath = self.tableView.indexPathsForSelectedRows!
        for p in selectedIndexpath {
            let minusPlayer = team.playersInTeam[p.row]
            addMinusInGame(player: minusPlayer)
        }
        
        for p in selectedIndexpath {
            tableView.deselectRow(at: p, animated: true)
        }
        self.tableView.reloadData()
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.playersInTeam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerNameAndStats", for: indexPath) as! PlayerTableViewCell
        cell.nameLabel.text = team.playersInTeam[indexPath.row].name
        cell.statsLabel.text = "\(team.playersInTeam[indexPath.row].gameTotal)"
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
