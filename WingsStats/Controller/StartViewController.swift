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
    var teams : [String] = []
    var idiot : Int = 10
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        existingTeams.dataSource = self
        existingTeams.delegate = self
        dataBase = Database.database().reference()
        
        createTeams()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.existingTeams.reloadAllComponents()
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
            self.dataBase.child("teams").observe(.value) { (teamSnapshot) in
            let teamSnapshotValue = teamSnapshot.value as! Dictionary<String,AnyObject>
            self.stringTeams = Array(teamSnapshotValue.keys.map{ $0 })
        
               
                
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
