//
//  TopListTableViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

class TopListTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var minusLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
}
class TopListTableViewController: UITableViewController {
    var teamName : String = ""
    var dataBase : DatabaseReference!
    var team : Team = Team()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBase = Database.database().reference()
        createTeam()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createTeam(){
        team.teamName = teamName
        self.dataBase.child("teams").child(team.teamName).observe(.value, with: { (playerSnapshot) in
            let playerSnapshotValue = playerSnapshot.value as! Dictionary<String,AnyObject>
            for (playerName, _) in playerSnapshotValue {
                let myPlayer = Player(name: playerName)
                print("PLAYER : \(myPlayer.name)")
                self.getPlayerStats(team: self.team.teamName, player: myPlayer)
                self.team.playersInTeam.append(myPlayer)
            }
        })
    }
    
    func getPlayerStats(team : String, player : Player){
        let playerName = player.name
        var snapshotValue : Int = 0
        dataBase.child("teams").child(team).child(playerName).child("plusStat").observe(.value, with: { (snapshot) in
            snapshotValue = snapshot.value as! Int
            player.plus = snapshotValue
        })
        dataBase.child("teams").child(team).child(playerName).child("minusStat").observe(.value, with: { (snapshot) in
            snapshotValue = snapshot.value as! Int
            player.minus = snapshotValue
        })
        dataBase.child("teams").child(team).child(playerName).child("total").observe(.value, with: { (snapshot) in
            snapshotValue = snapshot.value as! Int
            player.total = snapshotValue
        })
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.playersInTeam.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopListTableViewCell", for: indexPath) as! TopListTableViewCell
        
        cell.nameLabel.text = team.playersInTeam[indexPath.row].name
        cell.plusLabel.text = "\(team.playersInTeam[indexPath.row].plus)"
        cell.minusLabel.text = "\(team.playersInTeam[indexPath.row].minus)"
        cell.totalLabel.text = "\(team.playersInTeam[indexPath.row].total)"
    
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
