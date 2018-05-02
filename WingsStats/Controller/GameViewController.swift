//
//  GameViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

class PlayerTableViewCell : UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
}


class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var team : Team = Team()
    @IBOutlet weak var tableView: UITableView!
    var dataBase : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataBase = Database.database().reference()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlusStat(_ sender: Any) {
        if let selectedIndexPaths = self.tableView.indexPathsForSelectedRows {
            if let playersExist = selectedIndexPaths.count as? Int, playersExist > 0  {
                for p in selectedIndexPaths {
                    let plusPlayer = team.playersInTeam[p.row]
                    addPlusInGame(player: plusPlayer)
                }
                
                for p in selectedIndexPaths {
                    tableView.deselectRow(at: p, animated: true)
                }
                self.tableView.reloadData()
            } else {
                presentStatsAlert()
            }
        } else {
            presentStatsAlert()
        }
    }
    @IBAction func addMinusStat(_ sender: Any) {
        if let selectedIndexPaths = self.tableView.indexPathsForSelectedRows {
            if let playersExist = selectedIndexPaths.count as? Int, playersExist > 0 {
                for p in selectedIndexPaths {
                let minusPlayer = team.playersInTeam[p.row]
                addMinusInGame(player: minusPlayer)
                }
            
                for p in selectedIndexPaths {
                    tableView.deselectRow(at: p, animated: true)
                }
                self.tableView.reloadData()
            } else {
                presentStatsAlert()
            }
        } else {
            presentStatsAlert()
        }
        
    }
    
    
    @IBAction func endGame(_ sender: Any) {
        for player in team.playersInTeam {
            dataBase.child("teams").child(team.teamName).child(player.name).child("plusStat").setValue(getPlusStatsValue(player: player) + player.gamePlus)
            dataBase.child("teams").child(team.teamName).child(player.name).child("minusStat").setValue(getMinusStatsValue(player: player) + player.gameMinus)
            dataBase.child("teams").child(team.teamName).child(player.name).child("total").setValue(getTotalStatsValue(player: player) + player.gameTotal)
            
            finishAGame(player: player)
        }
        
        // FÅ VC:N ATT STÄNGA NER SIG EFTER DETTA SÅ ATT MAN INTE KAN ÄNDRA MER I MATCHEN.
    }
    
    func getPlusStatsValue(player : Player) -> Int{
        var snapshotValue : Int = 0
        dataBase.child("teams").child(team.teamName).child(player.name).child("plusStat").observe(.value, with: {  (snapshot) in
            snapshotValue = snapshot.value as! Int
        })
        print(snapshotValue)
        return snapshotValue
    }
    func getMinusStatsValue(player : Player) -> Int {
        var snapshotValue : Int = 0
        dataBase.child("teams").child(team.teamName).child(player.name).child("minusStat").observe(.value, with: { (snapshot) in
            snapshotValue = snapshot.value as! Int
        })
        print(snapshotValue)
        return snapshotValue
    }
    func getTotalStatsValue(player : Player) -> Int{
        var snapshotValue : Int = 0
        dataBase.child("teams").child(team.teamName).child(player.name).child("total").observe(.value, with: { (snapshot) in
            snapshotValue = snapshot.value as! Int
        })
        print(snapshotValue)
        return snapshotValue
    }
    
    
    func presentStatsAlert() {
        let alert = UIAlertController(title: "Error", message: "You have to choose a player to add stats for.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
