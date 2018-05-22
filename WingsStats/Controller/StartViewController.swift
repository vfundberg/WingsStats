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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        existingTeams.dataSource = self
        existingTeams.delegate = self
        dataBase = Database.database().reference()
        
        createTeams()
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
//                 self.stringTeams.contains(team) {
//                    print("Team already exists in the pickerview")
//                } else {
//                    let myteam = Team()
                    print("TEAM : \(team)")
//                    myteam.teamName = team
//                    self.teams.append(myteam)
                    self.stringTeams.append(team)
            }
            print(self.stringTeams)
            DispatchQueue.main.async {
                self.existingTeams.reloadAllComponents()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let valueSelected = stringTeams[row]
//    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stringTeams.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stringTeams[row]
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTotals" {
            let destinationVC = segue.destination as! TopListTableViewController
            destinationVC.teamName = stringTeams[existingTeams.selectedRow(inComponent: 0)]
        } else if segue.identifier == "existingTeamGame" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.teamName = stringTeams[existingTeams.selectedRow(inComponent: 0)]
        }
    }
    
}
