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
    let teams = ["A-laget","B-laget","Juniorerna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBase = Database.database().reference()
        checkIfTeamsExist()
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
    
    
    
    
    
    func checkIfTeamsExist() {
        // kolla igenom databasen ifall det finns några lag med i den, i sånna fall så ska knappen med starta med lag visas, annars inte
        //if lag finns {
        // print("Teams are existing in the database")
        //} else {
        //existingTeamButton.isHidden = true
        //}
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams[row]
    }
    
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view
//    }
    
}
