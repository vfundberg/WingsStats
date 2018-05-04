//
//  StartViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-13.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var existingTeams: UIPickerView!
    @IBOutlet weak var existingTeamButton: UIButton!
    @IBOutlet weak var totalsButton: UIButton!
    
    
    var dataBase : DatabaseReference!
    var stringTeams : [String] = []
    var teams : [Team] = []
    var randomTeams : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        existingTeams.dataSource = self
        existingTeams.delegate = self
        dataBase = Database.database().reference()
        
        //hideExistingButtons()
        createTeams()
        randomTeams = ["Victor","Mani","Robin"]
        
        //checkteamsbro()
        // checkIfTeamsExist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showTotals(_ sender: Any) {
        
    }
    @IBAction func gameWithExistingTeam(_ sender: Any) {
        
    }
    @IBAction func gameWithNewTeam(_ sender: Any) {
        
    }
    
    func createTeams() {
        dataBase.child("teams").observe(.value) { (teamSnapshot) in
            let teamSnapshotValue = teamSnapshot.value as! Dictionary<String,AnyObject>
            for (team, _) in teamSnapshotValue {
                let myteam = Team()
                print("TEAM : \(team)")
                myteam.teamName = team
                self.teams.append(myteam)
                self.stringTeams.append(myteam.teamName)
                self.dataBase.child("teams").child(myteam.teamName).observe(.value, with: { (playerSnapshot) in
                    let playerSnapshotValue = playerSnapshot.value as! Dictionary<String,AnyObject>
                    for (playerName, _) in playerSnapshotValue {
                        let myPlayer = Player(name: playerName)
                        print("PLAYER : \(myPlayer.name)")
                        self.getPlayerStats(team: myteam.teamName, player: myPlayer)
                        myteam.playersInTeam.append(myPlayer)
                    }
                })
            }
            print(self.stringTeams)
            print(self.randomTeams)
            DispatchQueue.main.async {
                self.existingTeams.reloadAllComponents()
            }
            
        }
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let valueSelected = stringTeams[row]
//    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("COUNT")
        return stringTeams.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stringTeams[row]
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTotals" {
            let destinationVC = segue.destination as! TopListTableViewController
            destinationVC.team = teams[existingTeams.selectedRow(inComponent: 0)]
        } else if segue.identifier == "existingTeamGame" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.team = teams[existingTeams.selectedRow(inComponent: 0)]
        }
    }
    
}
